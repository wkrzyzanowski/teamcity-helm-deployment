# Custom Docker teamcity_agent_1
FROM jetbrains/teamcity-agent:2021.1.2-linux-sudo

USER root

ARG build_agent_number

ENV BUILD_AGENT_NO=$build_agent_number

ENV DOCKER_IN_DOCKER="start"

ENV SERVER_URL="http://localhost:8111"

RUN mkdir -p /var/teamcity/agents/agent_${BUILD_AGENT_NO}/opt/buildagent_${BUILD_AGENT_NO}

#RUN mkdir -p /var/teamcity/agents/agent_${BUILD_AGENT_NO}/data/teamcity_agent/conf

RUN cp -r /opt/buildagent/* /var/teamcity/agents/agent_${BUILD_AGENT_NO}/opt/buildagent_${BUILD_AGENT_NO}

#RUN cp -r /data/teamcity_agent/conf/* /var/teamcity/agents/agent_${BUILD_AGENT_NO}/data/teamcity_agent/conf

RUN chown -R buildagent /var/teamcity/agents/agent_${BUILD_AGENT_NO}/opt/buildagent_${BUILD_AGENT_NO}

#RUN chown -R buildagent /var/teamcity/agents/agent_${BUILD_AGENT_NO}/data/teamcity_agent/conf

RUN sed -i 's/AGENT_DIST=\/opt\/buildagent/AGENT_DIST=\/var\/teamcity\/agents\/agent_\${BUILD_AGENT_NO}\/opt\/buildagent_\${BUILD_AGENT_NO}/g' /run-agent.sh

#RUN sed -i 's/CONFIG_DIR=\/data\/teamcity_agent\/conf/CONFIG_DIR=\/var\/teamcity\/agents\/agent_\${BUILD_AGENT_NO}\/data\/teamcity_agent\/conf/g' /run-agent.sh

RUN sed -i 's/LOG_DIR=\/opt\/buildagent\/logs/LOG_DIR=\/var\/teamcity\/agents\/agent_\${BUILD_AGENT_NO}\/opt\/buildagent_\${BUILD_AGENT_NO}\/logs/g' /run-agent.sh

USER buildagent