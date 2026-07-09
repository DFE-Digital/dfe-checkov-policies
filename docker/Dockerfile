FROM bridgecrew/checkov@sha256:39894d0672bb53c913b9784614f05c98de167cb2041ff96aa53dbd64a0b4a159 AS base

COPY policies/common /opt/policies
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV CHECKOV_POLICIES=/opt/policies

ENTRYPOINT ["/entrypoint.sh"]


FROM base AS elz

COPY policies/elz /opt/policies

FROM base AS cip

COPY policies/cip /opt/policies