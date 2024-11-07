function Controller() {
    installer.autoAcceptLicenses(); // 라이센스 자동 동의
}

Controller.prototype.IntroductionPageCallback = function() {
    gui.clickButton(buttons.NextButton); // 다음 페이지로 자동 이동
}

Controller.prototype.TargetDirectoryPageCallback = function() {
    // 현재 실행 중인 디렉터리 경로를 가져와서 설치 경로로 설정
    var currentDir = QDir.currentPath();
    gui.currentPageWidget().TargetDirectoryLineEdit.setText(currentDir); // 현재 디렉터리에 설치 경로 설정
    gui.clickButton(buttons.NextButton);
}

Controller.prototype.ComponentSelectionPageCallback = function() {
    gui.clickButton(buttons.NextButton); // 컴포넌트 선택 페이지를 넘어감
}

Controller.prototype.LicenseAgreementPageCallback = function() {
    gui.clickButton(buttons.AcceptLicenseButton); // 라이센스 동의
}

Controller.prototype.ReadyForInstallationPageCallback = function() {
    gui.clickButton(buttons.NextButton); // 설치 시작
}

Controller.prototype.FinishedPageCallback = function() {
    gui.clickButton(buttons.FinishButton); // 설치 완료 후 종료
}
