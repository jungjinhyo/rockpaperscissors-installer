function Component() {
    // 컴포넌트 초기화
    component.ifwVersion = installer.value("FrameworkVersion");
    installer.installationStarted.connect(this, Component.prototype.onInstallationStarted);
}

Component.prototype.onInstallationStarted = function() {
    if (component.updateRequested() || component.installationRequested()) {
        // 운영체제에 맞게 설치 프로그램 경로 설정
        var binaryPath = installer.value("TargetDir") + "/RockPaperScissors.exe";
       
        // 최신 버전 체크
        installer.setInstallerBaseBinary(binaryPath);
        var updateResourceFilePath = installer.value("TargetDir") + "/update.rcc";
        installer.setValue("DefaultResourceReplacement", updateResourceFilePath);
    }
};
