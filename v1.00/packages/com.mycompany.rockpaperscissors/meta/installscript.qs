function Component() {
    // 컴포넌트 초기화
    component.ifwVersion = installer.value("FrameworkVersion");
    installer.installationStarted.connect(this, Component.prototype.onInstallationStarted);
}

Component.prototype.onInstallationStarted = function() {
    var targetDir = installer.value("TargetDir");
    var exePath = targetDir + "/RockPaperScissors.exe";

    // 1. RockPaperScissors.exe 복사 작업 수행
    if (!installer.fileExists(exePath)) {
        component.addOperation("Copy", "data/RockPaperScissors.exe", exePath);
        console.log("RockPaperScissors.exe copied to: " + exePath);
    } else {
        console.log("RockPaperScissors.exe already exists.");
    }

    // 2. 최신 버전 체크 및 설정
    if (component.updateRequested() || component.installationRequested()) {
        console.log("Update requested or new installation.");

        // 기본 실행 파일 설정
        installer.setInstallerBaseBinary(exePath);

        // 업데이트 리소스 설정
        var updateResourceFilePath = targetDir + "/update.rcc";
        installer.setValue("DefaultResourceReplacement", updateResourceFilePath);
    }
};