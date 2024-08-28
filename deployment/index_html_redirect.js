function redirectTo(newUrl) {
	return {
		statusCode: 301,
		statusDescription: "Found",
		headers: { location: { value: newUrl } },
	};
}

function handler(event) {
	const request = event.request;
	const host = request.headers.host.value;

	if (host.startsWith("www.")) {
		return redirectTo(`https://${host.slice(4)}${request.uri}`);
	} else if (request.uri.endsWith("/")) {
		request.uri += "index.html";
	} else if (!request.uri.includes(".")) {
		request.uri += "/index.html";
	}

	return request;
}
