function Component() {
    component.ifwVersion = installer.value("FrameworkVersion");
    installer.installationStarted.connect(this, Component.prototype.onInstallationStarted);
}

Component.prototype.onInstallationStarted = function() {
    if (component.updateRequested() || component.installationRequested()) {
        if (installer.value("os") == "win") {
            component.installerbaseBinaryPath = "@TargetDir@/RockPaperScissors.exe";
        } else if (installer.value("os") == "x11") {
            component.installerbaseBinaryPath = "@TargetDir@/RockPaperScissors";
        } else if (installer.value("os") == "mac") {
            // macOS의 경우, 실행 파일이 MaintenanceTool 또는 RockPaperScissors로 제공됩니다.
            if (installer.versionMatches(component.ifwVersion, "<4.8.0")) {
                component.installerbaseBinaryPath = "@TargetDir@/MaintenanceTool.app";
            } else {
                component.installerbaseBinaryPath = "@TargetDir@/tmpMaintenanceToolApp/RockPaperScissors.app";
            }
        }

        // 기본 실행 파일 설정
        installer.setInstallerBaseBinary(component.installerbaseBinaryPath);

        // 업데이트 리소스 설정
        var updateResourceFilePath = installer.value("TargetDir") + "/update.rcc";
        installer.setValue("DefaultResourceReplacement", updateResourceFilePath);
    }
};

Component.prototype.createOperationsForArchive = function(archive) {
    // IFW 4.8.1 이후부터는 유지관리 도구를 폴더로 추출하는 것이 좋습니다.
    if (installer.versionMatches(component.ifwVersion, "<4.8.0")) {
        component.createOperationsForArchive(archive);
    } else {
        component.addOperation("Extract", archive, "@TargetDir@/launcher");
    }
};
