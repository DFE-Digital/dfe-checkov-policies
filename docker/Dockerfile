FROM bridgecrew/checkov@sha256:7407699a91a556849ae66e05c3753f58cf0ce922aa6ddfac7839aad4f390c016 AS base

COPY policies/common /opt/policies
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV CHECKOV_POLICIES=/opt/policies

ENTRYPOINT ["/entrypoint.sh"]


FROM base AS elz

COPY policies/elz /opt/policies

FROM base AS cip

COPY policies/cip /opt/policies