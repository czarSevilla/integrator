FROM registry.access.redhat.com/ubi9 AS ubi-micro-build

# Instalar curl en un directorio temporal para copiarlo después
RUN mkdir -p /mnt/rootfs && \
    dnf install --installroot /mnt/rootfs curl --releasever 9 --setopt install_weak_deps=false --nodocs -y && \
    dnf --installroot /mnt/rootfs clean all

# Stage 1: Build Keycloak with desired configurations
FROM quay.io/keycloak/keycloak:latest as builder_stage

ENV KC_DB=postgres

WORKDIR /opt/keycloak

COPY ps-theme /opt/keycloak/themes/ps-theme

RUN /opt/keycloak/bin/kc.sh build \
    --db=${KC_DB} \
    --health-enabled=true \
    --metrics-enabled=true

# Stage 2: Create the final production image
# No 'AS' needed for the final stage, or give it a distinct name like 'final_image'
FROM quay.io/keycloak/keycloak:latest 

# Copy the built artifacts from the 'builder_stage'
COPY --from=builder_stage /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
COPY --from=ubi-micro-build /mnt/rootfs/usr/bin/curl /usr/bin/curl
COPY --from=ubi-micro-build /mnt/rootfs/usr/lib64/* /usr/lib64/
COPY realm-ps.json /opt/keycloak/data/import/realm-poc.json
COPY --from=builder_stage /opt/keycloak/themes/ /opt/keycloak/themes/

# Set runtime environment variables.
ENV KC_DB=postgres
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME=https://sso.cesarsevilla.live
ENV KC_HOSTNAME_STRICT=false
ENV KC_PROXY=edge
ENV KC_PROXY_HEADERS=forwarded
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Define the entrypoint to start Keycloak in optimized mode
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

CMD ["start", "--optimized", "--hostname-strict=false", \
     "--hostname=https://sso.cesarsevilla.live",  \
     "--proxy-headers=forwarded",  \
     "--http-enabled=true", "--import-realm"]
