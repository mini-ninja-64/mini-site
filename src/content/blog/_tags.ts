import { z } from "astro:content";
import type { PostCollection } from "./_collection";

export interface TagDefinition {
	icon: string;
	description: string;
	implicitTags?: TagEnum[];
}

export const tagsArray = ["Self", "Astro", "JavaScript", "TypeScript"] as const;
export const tags = z.enum(tagsArray);
export type TagEnum = z.infer<typeof tags>;

export const tagDefinitions: Record<TagEnum, TagDefinition> = {
	Self: {
		icon: "",
		description:
			'Self relates to any "meta" blog posts about my website or blog.',
	},
	Astro: {
		icon: "",
		description:
			"Astro is a JavaScript web framework optimized for building fast, content-driven websites.",
		implicitTags: ["JavaScript", "TypeScript"],
	},
	TypeScript: {
		icon: "",
		description:
			"TypeScript is a programming language used for blah blah blah blah",
		implicitTags: ["JavaScript"],
	},
	JavaScript: {
		icon: "",
		description:
			"JavaScript is a programming language used for blah blah blah blah",
	},
};

function recurseTags(tag: TagEnum): TagEnum[] {
	const definition = tagDefinitions[tag];
	const implicitTags =
		definition.implicitTags?.flatMap((implicitTag) =>
			recurseTags(implicitTag),
		) || [];
	return [tag, ...implicitTags];
}

export function getAllTags(post: PostCollection): TagEnum[] {
	return [...new Set(post.tags.flatMap((tag) => recurseTags(tag)))];
}
