FROM bridgecrew/checkov@sha256:c41d3b95e0d1de6d0e288fc77541b11a9c55ff0b20c1ad3c981d29e079a5fb0e AS base

COPY policies/common /opt/policies
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV CHECKOV_POLICIES=/opt/policies

ENTRYPOINT ["/entrypoint.sh"]


FROM base AS elz

COPY policies/elz /opt/policies

FROM base AS cip

COPY policies/cip /opt/policies