import { z, defineCollection } from "astro:content";
import { tags } from "./_tags";

export default defineCollection({
	type: "content",
	schema: z.object({
		date: z.coerce.date(),
		title: z.string(),
		summary: z.string(),
		hero: z.string(),
		tags: z.array(tags).default([])
	}),
});
