FROM bridgecrew/checkov@sha256:41c4701c6a56d8952e5aba7a420f871c8b70b57da94eb4f142dcdf7295bb0be3 AS base

COPY policies/common /opt/policies
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV CHECKOV_POLICIES=/opt/policies

ENTRYPOINT ["/entrypoint.sh"]


FROM base AS elz

COPY policies/elz /opt/policies

FROM base AS cip

COPY policies/cip /opt/policies