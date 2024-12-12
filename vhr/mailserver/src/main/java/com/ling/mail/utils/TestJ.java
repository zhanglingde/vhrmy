package com.ling.mail.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.zip.Deflater;
import java.util.zip.DeflaterOutputStream;

public class TestJ {
    public static void main(String[] args) {

        String xmlKey = "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iZ2JrIiA/PjxidXNpbmVzcyBjb21tZW50PSLlj5HnpajmiZPljbAiIGlkPSI5MzAxMCI+PGJvZHkgeXlseGRtPSIxIj48ZnBseGRtPjMzPC9mcGx4ZG0+PGR5ZnM+MDwvZHlmcz48a3B4eD48ZnBkbT4xMzUwMjI0MjEzMDY8L2ZwZG0+PGZwaG0+MDAxNjEzMTY8L2ZwaG0+PHNmd3l4Ymp0ZHlzLz48ZnB6dD4wMDwvZnB6dD48a3BycT4yMDI0MTEyMTwva3BycT48anFiaC8+PHNrbT7mlbDnlLXnpajlj7fnoIHvvJoyNDk0MjAwMDAwMDA1MjYzNTc2N+WFqOWbveWinuWAvOeojuWPkeelqOafpemqjOW5s+WPsO+8mmh0dHBzOi8vaW52LXZlcmkuY2hpbmF0YXguZ292LmNuLzwvc2ttPjxnaGZtYz7okKXlj6PkuqTpgJrov5DovpPpm4blm6LmnInpmZDlhazlj7g8L2doZm1jPjxzZnpobS8+PGdoZnNiaD45MTIxMDgwMDY2NzI3MTI3MUo8L2doZnNiaD48c2NxeW1jPuWOpumXqOmHkem+meaXheihjOi9puaciemZkOWFrOWPuDwvc2NxeW1jPjxjbGx4Pue6r+eUteWKqOWfjuW4guWuoui9pjwvY2xseD48Y3B4aD7ph5Hml4XniYxYTUw2MTI1SkVWSjBDMzwvY3B4aD48Y2Q+5Y6m6ZeoPC9jZD48aGd6aD5YTjA5MDAwMDM5MDI4MDE8L2hnemg+PGprem1zaD7ml6A8L2prem1zaD48c2pkaD7ml6A8L3NqZGg+PGZkamhtPkQxMDAxMDIyNDA5MjAwODwvZmRqaG0+PGNqaG0+TEwzQUhDSjQ1UkEwMzI4MDE8L2NqaG0+PGpzaGo+MTA4MDAwMC4wMDwvanNoaj48eGhkd21jPuWOpumXqOmHkem+meaXheihjOi9puaciemZkOWFrOWPuDwveGhkd21jPjx4aGR3c2JoPjkxMzUwMjAwNjEyMDEyNTIwWDwveGhkd3NiaD48ZGg+NTYwODg2NzwvZGg+PHpoPjM1MTAxNTYxMDAxMDU5NjAwNjg2PC96aD48ZHo+5Y6m6Zeo5biC5rmW6YeM5bel5Lia5Yy65rmW6YeM5aSn6YGTNjnlj7c8L2R6PjxraHloPuS4reWbveW7uuihjOWOpumXqOW4guWIhuihjOWOpuemvuaUr+ihjDwva2h5aD48enpzc2w+MC4xMzwvenpzc2w+PHp6c3NlPjEyNDI0Ny43OTwvenpzc2U+PHN3amdkbT4xMzUwMjUyMTcwMDwvc3dqZ2RtPjxzd2pnbWM+5Zu95a6256iO5Yqh5oC75bGA5Y6m6Zeo5biC5rmW6YeM5Yy656iO5Yqh5bGA56ys5LqM56iO5Yqh5omAPC9zd2pnbWM+PGJoc2o+OTU1NzUyLjIxPC9iaHNqPjx3c3B6aG0vPjxkdy8+PHhjcnM+OTk8L3hjcnM+PGxzbGJzLz48Yno+5LiA6L2m5LiA56WoPC9iej48a3ByPuW+kOWPuOaZqDwva3ByPjxweWJzPjE8L3B5YnM+PC9rcHh4PjwvYm9keT48L2J1c2luZXNzPg==";
        String base64UrlSafeString = xmlKey
                .replace('+', '-')
                .replace('/', '_')
                .replaceAll("=", "");
        System.out.println(base64UrlSafeString);
    }

    private static byte[] compressXml(String xml) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try (DeflaterOutputStream dos = new DeflaterOutputStream(baos, new Deflater(Deflater.BEST_COMPRESSION))) {
            dos.write(xml.getBytes("GBK"));
        }
        return baos.toByteArray();
    }
}
