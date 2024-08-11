export function withTrailingSlash(original: URL): URL {
	var finalChar = original.pathname.slice(-1);
	var newUrl = new URL(original);
	if (finalChar !== "/") newUrl.pathname += "/";
	return newUrl;
}
