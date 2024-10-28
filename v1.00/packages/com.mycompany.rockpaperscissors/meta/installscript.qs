function Component() {
    installer.installationStarted.connect(this, Component.prototype.onInstallationStarted);
}

Component.prototype.onInstallationStarted = function() {
    var targetDir = installer.value("TargetDir");
    var exePath = targetDir + "/RockPaperScissors.exe";

    // 최신 버전 체크
    if (component.updateRequested() || component.installationRequested()) {
        console.log("Update requested or new installation.");

        // 기본 실행 파일 설정
        installer.setInstallerBaseBinary(exePath);

        // 업데이트 리소스 설정
        var updateResourceFilePath = targetDir + "/update.rcc";
        installer.setValue("DefaultResourceReplacement", updateResourceFilePath);
    }
};
