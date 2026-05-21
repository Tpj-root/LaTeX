(async () => {
    // Get all <a> links
    const links = [...document.querySelectorAll("a[href]")];

    // Extract hrefs
    let urls = links.map(a => a.href);

    // Keep only texample.net links
    urls = urls.filter(url => url.includes("texample.net"));

    // Remove duplicates
    urls = [...new Set(urls)];

    // Sort
    urls.sort();

    console.log("Total URLs:", urls.length);
    console.log(urls);

    // Create txt content
    const txt = urls.join("\n");

    // Download txt file
    const blob = new Blob([txt], { type: "text/plain" });
    const downloadUrl = URL.createObjectURL(blob);

    const a = document.createElement("a");
    a.href = downloadUrl;
    a.download = "texample_urls.txt";
    document.body.appendChild(a);
    a.click();
    a.remove();

    URL.revokeObjectURL(downloadUrl);

    console.log("Saved as texample_urls.txt");
})();
