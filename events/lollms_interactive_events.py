"""
project: lollms
file: lollms_discussion_events.py 
author: ParisNeo
description: 
    This module contains a set of Socketio routes that provide information about the Lord of Large Language and Multimodal Systems (LoLLMs) Web UI
    application. These routes are specific to discussion operation

"""
from fastapi import APIRouter, Request
from fastapi import HTTPException
from pydantic import BaseModel
import pkg_resources
from lollms.server.elf_server import LOLLMSElfServer
from fastapi.responses import FileResponse
from lollms.binding import BindingBuilder, InstallOption
from ascii_colors import ASCIIColors
from lollms.personality import MSG_TYPE, AIPersonality
from lollms.types import MSG_TYPE, SENDER_TYPES
from lollms.utilities import load_config, trace_exception, gc
from lollms.utilities import find_first_available_file_index, convert_language_name, PackageManager, run_async, add_period
from lollms.security import forbid_remote_access, check_access
from lollms_webui import LOLLMSWebUI
from pathlib import Path
from typing import List
from functools import partial
import socketio
import threading
import os
import time

from lollms.databases.discussions_database import Discussion
from datetime import datetime

router = APIRouter()
lollmsElfServer:LOLLMSWebUI = LOLLMSWebUI.get_instance()


# ----------------------------------- events -----------------------------------------
def add_events(sio:socketio):
    forbid_remote_access(lollmsElfServer)
    @sio.on('start_webcam_video_stream')
    def start_webcam_video_stream(sid):
        lollmsElfServer.info("Starting video capture")
        try:
            from lollms.media import WebcamImageSender
            lollmsElfServer.webcam = WebcamImageSender(sio,lollmsCom=lollmsElfServer)
            lollmsElfServer.webcam.start_capture()
        except:
            lollmsElfServer.InfoMessage("Couldn't load media library.\nYou will not be able to perform any of the media linked operations. please verify the logs and install any required installations")

    @sio.on('stop_webcam_video_stream')
    def stop_webcam_video_stream(sid):
        lollmsElfServer.info("Stopping video capture")
        lollmsElfServer.webcam.stop_capture()

    @sio.on('start_audio_stream')
    def start_audio_stream(sid):
        client = check_access(lollmsElfServer, sid)
        if lollmsElfServer.config.headless_server_mode:
            return {"status":False,"error":"Start recording is blocked when in headless mode for obvious security reasons!"}

        if lollmsElfServer.config.host!="localhost" and lollmsElfServer.config.host!="127.0.0.1":
            return {"status":False,"error":"Start recording is blocked when the server is exposed outside for very obvious reasons!"}

        lollmsElfServer.info("Starting audio capture")
        try:
            from lollms.media import AudioRecorder
            lollmsElfServer.rec_output_folder = lollmsElfServer.lollms_paths.personal_outputs_path/"audio_rec"
            lollmsElfServer.rec_output_folder.mkdir(exist_ok=True, parents=True)
            lollmsElfServer.summoned = False
            lollmsElfServer.audio_cap = AudioRecorder( client.discussion.discussion_folder/"audio"/"rt.wav", sio, callback=lollmsElfServer.audio_callback,lollmsCom=lollmsElfServer, transcribe=True)
            lollmsElfServer.audio_cap.start_recording()
        except Exception as ex:
            trace_exception(ex)
            lollmsElfServer.InfoMessage("Couldn't load media library.\nYou will not be able to perform any of the media linked operations. please verify the logs and install any required installations")



    @sio.on('stop_audio_stream')
    def stop_audio_stream(sid):
        client = check_access(lollmsElfServer, sid)
        lollmsElfServer.info("Stopping audio capture")
        text = lollmsElfServer.audio_cap.stop_recording()
        if lollmsElfServer.config.debug:
            ASCIIColors.yellow(text)
        
        ai_text = lollmsElfServer.receive_and_generate(text["text"], client)
        
        if lollmsElfServer.tts and lollmsElfServer.tts.ready:
            personality_audio:Path = lollmsElfServer.personality.personality_package_path/"audio"
            voice=lollmsElfServer.config.xtts_current_voice
            if personality_audio.exists() and len([v for v in personality_audio.iterdir()])>0:
                voices_folder = personality_audio
            elif voice!="main_voice":
                voices_folder = lollmsElfServer.lollms_paths.custom_voices_path
            else:
                voices_folder = Path(__file__).parent.parent.parent/"services/xtts/voices"
            language = lollmsElfServer.config.xtts_current_language# convert_language_name()
            lollmsElfServer.tts.set_speaker_folder(voices_folder)
            preprocessed_text= add_period(ai_text)
            voice_file =  [v for v in voices_folder.iterdir() if v.stem==voice and v.suffix==".wav"]

            lollmsElfServer.tts.tts_to_audio(preprocessed_text, voice_file[0].name, language=language)


