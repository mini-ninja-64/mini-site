import { z, defineCollection, getCollection } from "astro:content";
import { tags } from "./_tags";

const PostCollection = z.object({
	date: z.coerce.date(),
	title: z.string(),
	summary: z.string(),
	hero: z.object({
		link: z.string(),
		alt: z.string(),
	}),
	tags: z.array(tags).default([]),
	draft: z.boolean().default(false),
});

export type PostCollection = z.infer<typeof PostCollection>;

export default defineCollection({
	type: "content",
	schema: PostCollection,
});

export async function getAllBlogPosts(includeDrafts: boolean = false) {
	const posts = await getCollection("blog");
	return posts
		.filter((post) => includeDrafts || !post.data.draft)
		.sort((a, b) => b.data.date.getTime() - a.data.date.getTime());
}
