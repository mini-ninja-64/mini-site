import { z } from "astro:content";

export interface Tag {
	icon: string;
	description: string;
	implicitTags?: TagEnum[];
}

export const tags = z.enum([
	"this", 
	"Astro",
	"JavaScript",
	"TypeScript"
]);
export type TagEnum = z.infer<typeof tags>;

const tagDefinitions: Record<TagEnum, Tag> = {
	this: {
		icon: "",
		description: ""
	},
	Astro: {
		icon: "",
		description: "",
		implicitTags: [ "JavaScript" ]
	},
	TypeScript: {
		icon: "",
		description: "",
		implicitTags: [ "JavaScript" ]
	},
	JavaScript: {
		icon: "",
		description: ""
	},
};
