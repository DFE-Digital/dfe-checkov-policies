import { govukEleventyPlugin } from '@x-govuk/govuk-eleventy-plugin'
import { pathPrefix } from "./path-prefix.js";

export default function(eleventyConfig) {
  eleventyConfig.addPassthroughCopy("content/assets/images");

  eleventyConfig.addPlugin(govukEleventyPlugin, {
    stylesheets: ['/assets/styles.css'],
    titleSuffix: 'Checkov Policies',
    templates: {
      sitemap: true,
      searchIndex: true
    },
    header: {
      logotype: {
        html: '<img src="/assets/images/department-for-education_white.png" alt="Department for Education">'
      },
      search: {
        indexPath: `${pathPrefix}search-index.json`,
        sitemapPath: '/sitemap'
      }
    },
    serviceNavigation: {
      serviceName: 'Checkov Policies',
      navigation: [
        {
          text: 'Getting started',
          href: '/getting-started/'
        },
        {
          text: 'Contributing',
          href: '/contributing/'
        },
        {
          text: 'Integration',
          href: '/integration/'
        },
        {
          text: 'Catalogue',
          href: '/policy-catalogue/'
        },
        {
          text: 'Development',
          href: '/policy-development/'
        }
      ]
    },
    footer: {
      logo: false,
      meta: {
        items: [
          {
            href: 'https://github.com/DFE-Digital/dfe-checkov-policies',
            text: 'GitHub repository'
          },
          {
            href: 'https://www.checkov.io/',
            text: 'Checkov documentation'
          },
          {
            href: 'https://github.com/bridgecrewio/checkov',
            text: 'Checkov GitHub repository'
          },
        ]
      }
    }
  })



  return {
    pathPrefix: pathPrefix,
    dataTemplateEngine: 'njk',
    htmlTemplateEngine: 'njk',
    markdownTemplateEngine: 'njk',
    dir: {
      input: 'content',
    }
  }
};