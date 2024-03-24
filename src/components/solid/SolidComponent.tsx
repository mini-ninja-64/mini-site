import { createSignal } from "solid-js";

export default function SolidComponent() {
	const [count, setCount] = createSignal(0);

	return (
		<div style={{ color: "aqua" }} onClick={() => setCount(count() + 1)}>
			This is a Component {count()}
		</div>
	);
}
