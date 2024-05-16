; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "AfriCrypt"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "Genuis Game"
#define MyAppURL "https://genuis-africrypt.web.app/"
#define MyAppExeName "africrypt.exe"
#define MyAppAssocName MyAppName + ""
#define MyAppAssocExt ".exe"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{74B5C426-BAF1-4DEE-B238-2D55AFF0E4AF}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableDirPage=yes
ChangesAssociations=yes
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputBaseFilename=AfriCrypt
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\africrypt.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\africrypt.exp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\africrypt.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\audioplayers_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\cloud_firestore_plugin.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\connectivity_plus_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\firebase_auth_plugin.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\firebase_core_plugin.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\pdfium.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\syncfusion_pdfviewer_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\rodrigue\IdeaProjects\AfriCrypt\build\windows\x64\runner\Release\url_launcher_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

