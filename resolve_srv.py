import dns.resolver

answers = dns.resolver.resolve('_mongodb._tcp.health360.pv0jd4x.mongodb.net', 'SRV')
hosts = [f'{a.target.to_text().rstrip(".")}:{a.port}' for a in answers]
print(','.join(hosts))
