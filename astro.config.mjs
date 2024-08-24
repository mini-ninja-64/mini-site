import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import solid from "@astrojs/solid-js";
import robotsTxt from "astro-robots-txt";
import sitemap from "@astrojs/sitemap";
import robotsConfig from "./robots.json";

export default defineConfig({
	site: "https://minis.zone",
	integrations: [
		mdx(),
		solid({
			include: "**/solid/**",
		}),
		robotsTxt({
			policy: robotsConfig.blocked.map((agent) => ({
				userAgent: agent,
				disallow: "/",
			})),
		}),
		sitemap(),
	],
});
