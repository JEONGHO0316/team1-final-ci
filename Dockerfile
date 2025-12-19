# Dockerfile
# 컨테이너의 기본 운영체제로 경량화된 OpenJDK 17 환경을 사용
FROM openjdk:17.0.1-jdk-slim

# 컨테이너 내부의 작업 디렉토리를 /app으로 설정
WORKDIR /app

# 빌드된 실행 파일(*.jar)을 /app으로 복사하고 이름을 app.jar로 변경
COPY target/*.jar app.jar

# 애플리케이션이 8080 포트를 통해 통신할 것을 알림
EXPOSE 8080

# 컨테이너 시작 시 app.jar 파일이 실행되도록 진입점 명령을 정의
ENTRYPOINT ["java", "-jar", "app.jar"]

