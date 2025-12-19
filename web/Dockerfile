# Dockerfile
# BaseImage로 가볍고 안정적인 alpine 리눅스 사용
FROM nginx:stable-alpine

# Nginx 이미지에 기본으로 포함된 /etc/nginx/conf.d/default.conf 설정을 삭제
RUN rm /etc/nginx/conf.d/default.conf

# 현재 디렉토리의 default.conf 파일을 컨테이너 내부의 /etc/nginx/conf.d/ 디렉토리로 복사
COPY default.conf /etc/nginx/conf.d/default.conf

# 컨테이너는 80번 포트 사용
EXPOSE 80

# 컨테이너가 시작될 때 Nginx를 포그라운드(foreground) 모드로 실행
CMD ["nginx", "-g", "daemon off;"]
