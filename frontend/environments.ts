export const environment = {
  apiUrl: '{{ APP_URL }}/api/v1',
  keycloak: {
    config: {
      url: '{{ KEYCLOAK_URL }}',
      realm: '{{ APP_REALM }}',
      clientId: '{{ APP_ADMIN_CLIENT_ID }}'
    },
    initOptions: {
      onLoad: 'login-required',
      checkLoginIframe: false,
    }
  }
};