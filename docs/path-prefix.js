export const pathPrefix =
    process.env.ELEVENTY_ENV === "production"
        ? "/dfe-checkov-policies/"
        : "/";