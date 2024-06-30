import { z, defineCollection } from "astro:content";
import { tags } from "./_tags";

const PostCollection = z.object({
	date: z.coerce.date(),
	title: z.string(),
	summary: z.string(),
	hero: z.string(),
	tags: z.array(tags).default([]),
});

export type PostCollection = z.infer<typeof PostCollection>;

export default defineCollection({
	type: "content",
	schema: PostCollection,
});
