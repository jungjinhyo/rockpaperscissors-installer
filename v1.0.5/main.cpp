// main.cpp
#include <QCoreApplication>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QUrl>
#include <QEventLoop>
#include <QRegularExpression>
#include <QStringList>

const QString UPDATES_URL = "https://jungjinhyo.github.io/rockpaperscissors-installer/";

QString findLatestVersion() {
    QNetworkAccessManager manager;
    QNetworkReply *reply = manager.get(QNetworkRequest(QUrl(UPDATES_URL)));

    QEventLoop loop;
    QObject::connect(reply, &QNetworkReply::finished, &loop, &QEventLoop::quit);
    loop.exec();

    QString latest_version;
    if (reply->error() == QNetworkReply::NoError) {
        QString html = reply->readAll();
        QRegularExpression regex(R"(v\d+\.\d+\.\d+)");
        QRegularExpressionMatchIterator i = regex.globalMatch(html);

        QStringList versions;
        while (i.hasNext()) {
            QRegularExpressionMatch match = i.next();
            versions << match.captured(0);
        }

        std::sort(versions.begin(), versions.end(), [](const QString &a, const QString &b) {
            return a > b;
        });

        if (!versions.isEmpty()) {
            latest_version = versions.first();
        }
    } else {
        qWarning() << "Failed to fetch updates: " << reply->errorString();
    }

    reply->deleteLater();
    return latest_version;
}

int main(int argc, char *argv[]) {
    QCoreApplication a(argc, argv);

    QString latest_version = findLatestVersion();
    qDebug() << "Latest version: " << latest_version;

    return a.exec();
}