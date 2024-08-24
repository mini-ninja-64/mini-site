import rss from "@astrojs/rss";
import { withTrailingSlash } from "../../utils/url";
import type { APIContext } from "astro";
import { title, description } from "./index.astro";
import { getAllBlogPosts } from "../../content/blog/_collection";

export async function GET(context: APIContext) {
	const allBlogPosts = await getAllBlogPosts();

	let blogUrl = context.site;
	if (import.meta.env.DEV) {
		blogUrl = new URL(context.url.origin);
	}
	if (blogUrl === undefined) throw new Error("Missing config for 'site'");
	blogUrl = withTrailingSlash(blogUrl);
	blogUrl.pathname += "blog";

	return rss({
		title,
		description,
		site: blogUrl,
		items: allBlogPosts
			.filter((post) => !post.data.draft)
			.map((post) => ({
				title: post.data.title,
				description: post.data.summary,
				link: `${blogUrl}/${post.slug}`,
				pubDate: post.data.date,
			})),
		customData: `<language>en-gb</language>`,
	});
}
