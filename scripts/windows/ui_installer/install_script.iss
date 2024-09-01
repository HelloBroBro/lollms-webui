; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Lollms"
#define MyAppVersion "12"
#define MyAppPublisher "ParisNeo"
#define MyAppURL "https://www.lollms.com/"
#define MyAppExeName "win_run.bat"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{28C9913A-657D-4F79-B78E-0459A203127E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={userdocs}\lollms
DisableProgramGroupPage=yes
LicenseFile=LICENSE.txt
InfoBeforeFile=lollms_intro.md
InfoAfterFile=CODE_OF_CONDUCT.md
; Remove the following line to run in administrative install mode (install for all users.)
PrivilegesRequired=lowest
OutputBaseFilename=lollms_setup
SetupIconFile=favicon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "../{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "first_install.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "../win_conda_session.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "../uninstall.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "logo.ico"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\logo.ico"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Code]
var
  OptionsPage: TInputOptionWizardPage;
  ElfRadioButton: TRadioButton;
  OpenRouterRadioButton: TRadioButton;
  GroqRadioButton: TRadioButton;
  MistralAIRadioButton: TRadioButton;
  OpenAIRadioButton: TRadioButton;
  OllamaRadioButton: TRadioButton;
  VllmRadioButton: TRadioButton;
  LitellmRadioButton: TRadioButton;
  Exllamav2RadioButton: TRadioButton;
  PythonLlamaCppRadioButton: TRadioButton;
  HuggingfaceRadioButton: TRadioButton;
  RemoteLollmsRadioButton: TRadioButton;
  XAIRadioButton: TRadioButton;
  GeminiRadioButton: TRadioButton;

procedure InitializeWizard;
begin
  OptionsPage := CreateInputOptionPage(wpSelectTasks,
    'Custom Options', 'Select the desired binding to install by default',
    'Please select one of the following options:',
    False, False);

  ElfRadioButton := TRadioButton.Create(OptionsPage);
  ElfRadioButton.Caption := 'elf';
  ElfRadioButton.Checked := True;
  ElfRadioButton.Parent := OptionsPage.Surface;
  ElfRadioButton.Top := 0;

  OpenRouterRadioButton := TRadioButton.Create(OptionsPage);
  OpenRouterRadioButton.Caption := 'openrouter';
  OpenRouterRadioButton.Checked := False;
  OpenRouterRadioButton.Parent := OptionsPage.Surface;
  OpenRouterRadioButton.Top := ElfRadioButton.Top + ElfRadioButton.Height + 8;

  GroqRadioButton := TRadioButton.Create(OptionsPage);
  GroqRadioButton.Caption := 'groq';
  GroqRadioButton.Checked := False;
  GroqRadioButton.Parent := OptionsPage.Surface;
  GroqRadioButton.Top := OpenRouterRadioButton.Top + OpenRouterRadioButton.Height + 8;

  MistralAIRadioButton := TRadioButton.Create(OptionsPage);
  MistralAIRadioButton.Caption := 'mistralai';
  MistralAIRadioButton.Checked := False;
  MistralAIRadioButton.Parent := OptionsPage.Surface;
  MistralAIRadioButton.Top := GroqRadioButton.Top + GroqRadioButton.Height + 8;

  OpenAIRadioButton := TRadioButton.Create(OptionsPage);
  OpenAIRadioButton.Caption := 'openai';
  OpenAIRadioButton.Checked := False;
  OpenAIRadioButton.Parent := OptionsPage.Surface;
  OpenAIRadioButton.Top := MistralAIRadioButton.Top + MistralAIRadioButton.Height + 8;

  OllamaRadioButton := TRadioButton.Create(OptionsPage);
  OllamaRadioButton.Caption := 'ollama';
  OllamaRadioButton.Checked := False;
  OllamaRadioButton.Parent := OptionsPage.Surface;
  OllamaRadioButton.Top := OpenAIRadioButton.Top + OpenAIRadioButton.Height + 8;

  VllmRadioButton := TRadioButton.Create(OptionsPage);
  VllmRadioButton.Caption := 'vllm';
  VllmRadioButton.Checked := False;
  VllmRadioButton.Parent := OptionsPage.Surface;
  VllmRadioButton.Top := OllamaRadioButton.Top + OllamaRadioButton.Height + 8;

  LitellmRadioButton := TRadioButton.Create(OptionsPage);
  LitellmRadioButton.Caption := 'litellm';
  LitellmRadioButton.Checked := False;
  LitellmRadioButton.Parent := OptionsPage.Surface;
  LitellmRadioButton.Top := VllmRadioButton.Top + VllmRadioButton.Height + 8;

  Exllamav2RadioButton := TRadioButton.Create(OptionsPage);
  Exllamav2RadioButton.Caption := 'exllamav2';
  Exllamav2RadioButton.Checked := False;
  Exllamav2RadioButton.Parent := OptionsPage.Surface;
  Exllamav2RadioButton.Top := LitellmRadioButton.Top + LitellmRadioButton.Height + 8;

  PythonLlamaCppRadioButton := TRadioButton.Create(OptionsPage);
  PythonLlamaCppRadioButton.Caption := 'python_llama_cpp';
  PythonLlamaCppRadioButton.Checked := False;
  PythonLlamaCppRadioButton.Parent := OptionsPage.Surface;
  PythonLlamaCppRadioButton.Top := Exllamav2RadioButton.Top + Exllamav2RadioButton.Height + 8;

  HuggingfaceRadioButton := TRadioButton.Create(OptionsPage);
  HuggingfaceRadioButton.Caption := 'huggingface';
  HuggingfaceRadioButton.Checked := False;
  HuggingfaceRadioButton.Parent := OptionsPage.Surface;
  HuggingfaceRadioButton.Top := PythonLlamaCppRadioButton.Top + PythonLlamaCppRadioButton.Height + 8;

  RemoteLollmsRadioButton := TRadioButton.Create(OptionsPage);
  RemoteLollmsRadioButton.Caption := 'remote_lollms';
  RemoteLollmsRadioButton.Checked := False;
  RemoteLollmsRadioButton.Parent := OptionsPage.Surface;
  RemoteLollmsRadioButton.Top := HuggingfaceRadioButton.Top + HuggingfaceRadioButton.Height + 8;

  XAIRadioButton := TRadioButton.Create(OptionsPage);
  XAIRadioButton.Caption := 'xAI';
  XAIRadioButton.Checked := False;
  XAIRadioButton.Parent := OptionsPage.Surface;
  XAIRadioButton.Top := RemoteLollmsRadioButton.Top + RemoteLollmsRadioButton.Height + 8;

  GeminiRadioButton := TRadioButton.Create(OptionsPage);
  GeminiRadioButton.Caption := 'gemini';
  GeminiRadioButton.Checked := False;
  GeminiRadioButton.Parent := OptionsPage.Surface;
  GeminiRadioButton.Top := XAIRadioButton.Top + XAIRadioButton.Height + 8;
end;

function GetSelectedOption(Param: string): string;
begin
  if ElfRadioButton.Checked then
    Result := '--elf'
  else if OpenRouterRadioButton.Checked then
    Result := '--openrouter'
  else if GroqRadioButton.Checked then
    Result := '--groq'
  else if MistralAIRadioButton.Checked then
    Result := '--mistralai'
  else if OpenAIRadioButton.Checked then
    Result := '--openai'
  else if OllamaRadioButton.Checked then
    Result := '--ollama'
  else if VllmRadioButton.Checked then
    Result := '--vllm'
  else if LitellmRadioButton.Checked then
    Result := '--litellm'
  else if Exllamav2RadioButton.Checked then
    Result := '--exllamav2'
  else if PythonLlamaCppRadioButton.Checked then
    Result := '--python_llama_cpp'
  else if HuggingfaceRadioButton.Checked then
    Result := '--huggingface'
  else if RemoteLollmsRadioButton.Checked then
    Result := '--remote_lollms'
  else if XAIRadioButton.Checked then
    Result := '--xAI'
  else if GeminiRadioButton.Checked then
    Result := '--gemini'
  else
    Result := '';
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if (CurStep = ssPostInstall) and (GetSelectedOption('') = '') then
  begin
    MsgBox('An option must be selected for installation to continue.', mbError, MB_OK);
    Abort;
  end;
end;

[Run]
Filename: {app}\first_install.bat; Parameters: "{code:GetSelectedOption}"; Flags: postinstall
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: shellexec postinstall skipifsilent

[UninstallRun]
Filename: {app}\uninstall.bat; RunOnceId: MyCustomUninstallAction
