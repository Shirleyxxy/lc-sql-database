-- Self join
SELECT DISTINCT l1.account_id
FROM LogInfo l1, LogInfo l2
WHERE l1.account_id = l2.account_id AND l1.ip_address != l2.ip_address
      AND (l1.logout BETWEEN l2.login AND l2.logout OR l2.logout BETWEEN l1.login AND l1.logout)


-- Self join + GREATEST / LEAST
-- Faster
SELECT DISTINCT l1.account_id
FROM LogInfo l1 JOIN LogInfo l2
ON l1.account_id = l2.account_id AND l1.ip_address != l2.ip_address
  AND LEAST(l1.logout, l2.logout) >= GREATEST(l1.login, l2.login)
