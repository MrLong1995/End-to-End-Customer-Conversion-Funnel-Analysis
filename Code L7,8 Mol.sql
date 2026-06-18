SELECT
    pt.maPT,
    pt.ngayLapPT,
    c.member_id,
    c.sdt,
    pt.maHD,
    pt.trangThaiThanhToan
FROM pvn.pt pt
LEFT JOIN pvn.contract c
    ON pt.maHD = c.maHD
WHERE pt.ngayLapPT >= '2026-06-01'
  AND pt.ngayLapPT < '2026-07-01'
  AND pt.nguonKH = 'MOL';