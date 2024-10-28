function Component() {
    // 컴포넌트 초기화
    component.ifwVersion = installer.value("FrameworkVersion");
    installer.installationStarted.connect(this, Component.prototype.onInstallationStarted);
}

Component.prototype.onInstallationStarted = function() {
    if (component.updateRequested() || component.installationRequested()) {
        // 설치 경로에서 실행 파일 경로 설정
        var binaryPath = installer.value("TargetDir") + "/RockPaperScissors.exe";

        // 최신 버전 체크 및 기본 실행 파일 설정
        installer.setInstallerBaseBinary(binaryPath);
        var updateResourceFilePath = installer.value("TargetDir") + "/update.rcc";
        installer.setValue("DefaultResourceReplacement", updateResourceFilePath);
    }
};
