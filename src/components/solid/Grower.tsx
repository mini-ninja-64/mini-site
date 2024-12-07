import { createSignal, type ParentProps } from "solid-js";

export default function Grower({ children }: ParentProps) {
	const [size, setSize] = createSignal(100);
	return (
		<span
			style={{
				cursor: "pointer",
				"font-size": `${size()}%`,
				"transition-duration": "1s",
			}}
			onClick={() => setSize(size() + 10)}
			// Prevent double click text selection
			onMouseDown={(event) => event.preventDefault()}
		>
			{children}
		</span>
	);
}
