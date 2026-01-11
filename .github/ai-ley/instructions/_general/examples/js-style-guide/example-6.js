// 1) Node built-ins, 2) external packages, 3) internal modules
import fs from 'node:fs';
import path from 'node:path';

import _ from 'lodash';
import dayjs from 'dayjs';

import { formatName } from '../utils/strings.js';

export function main() {
	const users = [
		{ first: 'Ada', last: 'Lovelace' },
		{ first: 'Grace', last: 'Hopper' },
	];

	// Prefer map + join over string concat in loops
	const names = users.map(formatName).join(', ');
	console.log(names);
}