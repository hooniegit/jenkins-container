FROM jenkins/jenkins:latest

ENV FLYCTL_VERSION=0.0.0  
ARG FLY_EMAIL
ARG FLY_PASSWORD

# install Fly.io CLI
RUN curl -L https://fly.io/install.sh | sh && \
    flyctl version $FLYCTL_VERSION

# flyctl auth login
RUN echo "$FLY_EMAIL\n$FLY_PASSWORD" | flyctl auth login

# Jenkins 홈 디렉토리 내에서 필요한 작업 수행
USER jenkins
WORKDIR /var/jenkins_home

# expose port
EXPOSE 8080

# Build
# $ docker build --build-arg FLY_EMAIL=$FLY_EMAIN --build-arg FLY_PASSWORD=$FLY_PASSWORD -t imgJenkins .
# $ docker run --name hoonieJenkins -p 8888:8080 -d imgJenkins