FROM bridgecrew/checkov@sha256:655c1f563d5c834d27d3884e46925939ea9abd234961c07f32fa997b01d927c2 AS base

COPY policies/common /opt/policies
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENV CHECKOV_POLICIES=/opt/policies

ENTRYPOINT ["/entrypoint.sh"]


FROM base AS elz

COPY policies/elz /opt/policies

FROM base AS cip

COPY policies/cip /opt/policies