import type { ParentProps } from "solid-js";

export default function Meowable({ children }: ParentProps) {
	return (
		<span style={{ cursor: "pointer" }} onClick={() => console.log("meow")}>
			{children}
		</span>
	);
}
