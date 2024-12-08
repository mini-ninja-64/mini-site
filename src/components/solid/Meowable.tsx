import { type ParentProps } from "solid-js";

export default function Meowable({ children }: ParentProps) {
	return (
		<span
			style={{ cursor: "pointer" }}
			onClick={() => {
				const audio = new Audio("/audio/meow1.mp3");
				audio.preservesPitch = false;
				audio.playbackRate = 1.0 - Math.random() * 0.25;
				audio.play().catch((e) => console.error(e));
			}}
			// Prevent double click text selection
			onMouseDown={(event) => event.preventDefault()}
		>
			{children}
		</span>
	);
}
