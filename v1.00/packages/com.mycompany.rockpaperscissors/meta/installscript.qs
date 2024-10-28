function Component() {
    // 컴포넌트 초기화
    component.ifwVersion = installer.value("FrameworkVersion");
    installer.installationStarted.connect(this, Component.prototype.onInstallationStarted);
}

Component.prototype.onInstallationStarted = function() {
    var targetDir = installer.value("TargetDir");
    var exePath = targetDir + "/RockPaperScissors.exe";

    // 1. 압축 파일 해제 작업 수행
    console.log("Extracting RockPaperScissors_v1.00.7z to: " + targetDir);
    component.addOperation("Extract", "data/RockPaperScissors_v1.00.7z", targetDir);

    // 2. RockPaperScissors.exe 복사 작업
    if (!installer.fileExists(exePath)) {
        console.log("Copying RockPaperScissors.exe to: " + exePath);
        component.addOperation("Copy", targetDir + "/RockPaperScissors.exe", exePath);
    } else {
        console.log("RockPaperScissors.exe already exists.");
    }

    // 3. 최신 버전 체크 및 설정
    if (component.updateRequested() || component.installationRequested()) {
        console.log("Update requested or new installation.");

        // 기본 실행 파일 설정
        installer.setInstallerBaseBinary(exePath);

        // 업데이트 리소스 설정
        var updateResourceFilePath = targetDir + "/update.rcc";
        installer.setValue("DefaultResourceReplacement", updateResourceFilePath);
    }
};
