FROM alpine
RUN apk add --no-cache --upgrade bash
RUN apk add sed 
RUN apk add openssh 
RUN apk add jq
COPY build.sh .
COPY BP-BASE-SHELL-STEPS .
RUN chmod +x build.sh
ENV ACTIVITY_SUB_TASK_CODE BP-STRING-REPLACE-TASK
ENV SLEEP_DURATION 10m
ENV PRIVATE_KEY_FILE ""
ENV NEW_VERSION ""
ENV FILE_PATH "deploy_buildpiper/docker-compose.yml"
ENV USERNAME ""
ENV IP_ADDRESS ""
ENV SSH_PORT ""
ENTRYPOINT [ "./build.sh" ]




