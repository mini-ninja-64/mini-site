import { defineConfig } from 'astro/config';

import mdx from '@astrojs/mdx';
import solid from '@astrojs/solid-js';

export default defineConfig({
    integrations: [
        mdx(),
        solid({
            
            include: "**/solid/**"
        })
    ],
    // markdown: {
    //     shikiConfig: {
    //         theme: "github-light"
    //     }
    // }
});
