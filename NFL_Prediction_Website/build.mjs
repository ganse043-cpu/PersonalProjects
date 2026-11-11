import {mkdir, readFile, writeFile} from "node:fs/promises";

await mkdir("dist/server", {recursive:true});
const types = {"index.html":"text/html", "app.js":"text/javascript", "styles.css":"text/css", "predictions.csv":"text/csv"};
const assets = {};
for (const [name, type] of Object.entries(types)) {
  assets["/" + name] = {type:type + "; charset=utf-8", content:await readFile("web/" + name,"utf8")};
}
const model = JSON.parse(await readFile("worker/model.json","utf8"));
const forecast = (await readFile("worker/forecast.mjs","utf8")).replace(/^export function /gm, "function ");
const worker = (await readFile("worker/index.mjs","utf8")).replace(/^import .*\n/gm, "");
await writeFile("dist/server/index.js", "const assets = " + JSON.stringify(assets) + ";\nconst model = " + JSON.stringify(model) + ";\n" + forecast + "\n" + worker);
