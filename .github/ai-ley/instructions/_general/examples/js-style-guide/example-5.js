/**
 * Formats a user’s display name.
 * @param {{ first: string, last: string }} user
 * @returns {string}
 */
export function formatName({ first, last }) {
	return `${first} ${last}`.trim();
}