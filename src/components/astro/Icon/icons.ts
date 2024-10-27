import type { PhosphorIcon } from "@phosphor-icons/core";

export type IconName = PhosphorIcon["name"];
export type IconWeight =
	| "bold"
	| "duotone"
	| "fill"
	| "light"
	| "regular"
	| "thin";

const svgLookups: Record<IconWeight, Record<string, () => Promise<any>>> = {
	bold: import.meta.glob(
		"../../../../node_modules/@phosphor-icons/core/assets/bold/*.svg",
		{ query: "raw" },
	),
	duotone: import.meta.glob(
		"../../../../node_modules/@phosphor-icons/core/assets/duotone/*.svg",
		{ query: "raw" },
	),
	fill: import.meta.glob(
		"../../../../node_modules/@phosphor-icons/core/assets/fill/*.svg",
		{ query: "raw" },
	),
	light: import.meta.glob(
		"../../../../node_modules/@phosphor-icons/core/assets/light/*.svg",
		{ query: "raw" },
	),
	regular: import.meta.glob(
		"../../../../node_modules/@phosphor-icons/core/assets/regular/*.svg",
		{ query: "raw" },
	),
	thin: import.meta.glob(
		"../../../../node_modules/@phosphor-icons/core/assets/thin/*.svg",
		{ query: "raw" },
	),
};

export const IconPromises = Object.fromEntries(
	Object.entries(svgLookups).map(([weight, files]) => [
		weight,
		Object.fromEntries(
			Object.entries(files).map(([filePath, fileImport]) => {
				const iconName = filePath
					.replace(
						`../../../../node_modules/@phosphor-icons/core/assets/${weight}/`,
						"",
					)
					.replace(`-${weight}.svg`, "")
					.replace(".svg", "");
				return [
					iconName,
					() =>
						fileImport().then((svgImport: { default: string }) => {
							return {
								html: svgImport.default
									.replace(/<svg.*?>/g, "")
									.replace(/<\/svg>/g, ""),
							};
						}),
				];
			}),
		),
	]),
) as Record<IconWeight, Record<IconName, () => Promise<{ html: string }>>>;
