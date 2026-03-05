-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2026 at 10:26 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopquick`
--

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` enum('user','agent') NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `product_name` varchar(200) NOT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `dietary_label` enum('halal','vegan','veg') DEFAULT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `product_name`, `brand`, `store_id`, `dietary_label`, `price`) VALUES
(1501, 'SQP-0075', 'Nestlé Tomato Sauce 12 pack', 'Nestlé', 5, 'vegan', 2.00),
(1502, 'SQP-0100', 'Quorn Tomato Passata 750g', 'Quorn', 10, 'veg', 1.00),
(1503, 'SQP-0071', 'Heinz Veggie Burger 12 pack', 'Heinz', 1, 'vegan', 2.00),
(1504, 'SQP-0074', 'Ben & Jerry\'s Chocolate Bar 500g', 'Ben & Jerry\'s', 3, 'veg', 1.00),
(1505, 'SQP-0112', 'Dolmio Salmon Fillets 250g', 'Dolmio', 9, 'halal', 6.00),
(1506, 'SQP-0110', 'Quorn Greek Yogurt 250g', 'Quorn', 1, 'veg', 4.00),
(1507, 'SQP-0142', 'Yeo Valley Ice Cream Tub 1L', 'Yeo Valley', 9, 'veg', 3.00),
(1508, 'SQP-0013', 'Warburtons Chocolate Bar 8 pack', 'Warburtons', 7, 'veg', 1.00),
(1509, 'SQP-0074', 'Ben & Jerry\'s Chocolate Bar 500g', 'Ben & Jerry\'s', 8, 'veg', 1.00),
(1510, 'SQP-0033', 'Ben & Jerry\'s Sparkling Water Family Size', 'Ben & Jerry\'s', 3, 'halal', 2.00),
(1511, 'SQP-0073', 'John West Lentils 2L', 'John West', 5, 'halal', 2.00),
(1512, 'SQP-0104', 'Yeo Valley Breakfast Cereal 2L', 'Yeo Valley', 4, 'veg', 3.00),
(1513, 'SQP-0101', 'Princes Chickpeas 2kg', 'Princes', 2, 'halal', 1.00),
(1514, 'SQP-0020', 'Tilda Chicken Breast Fillets 6 pack', 'Tilda', 4, 'halal', 7.00),
(1515, 'SQP-0141', 'Arla Bread Loaf 250g', 'Arla', 4, 'veg', 2.00),
(1516, 'SQP-0116', 'Arla Bread Loaf 2kg', 'Arla', 7, 'veg', 1.00),
(1517, 'SQP-0063', 'Nando\'s Tofu 2L', 'Nando\'s', 2, 'vegan', 2.00),
(1518, 'SQP-0024', 'Warburtons Cheddar Cheese Family Size', 'Warburtons', 6, 'veg', 3.00),
(1519, 'SQP-0146', 'Princes Olive Oil 250g', 'Princes', 4, 'vegan', 9.00),
(1520, 'SQP-0099', 'Green Giant Tomato Sauce 750g', 'Green Giant', 7, 'vegan', 2.00),
(1521, 'SQP-0097', 'Dolmio Bread Loaf Family Size', 'Dolmio', 5, 'veg', 1.00),
(1522, 'SQP-0128', 'Heinz Chicken Breast Fillets 6 pack', 'Heinz', 5, 'halal', 7.00),
(1523, 'SQP-0033', 'Ben & Jerry\'s Sparkling Water Family Size', 'Ben & Jerry\'s', 9, 'halal', 1.00),
(1524, 'SQP-0024', 'Arla Cheddar Cheese Family Size', 'Arla', 5, 'veg', 5.00),
(1525, 'SQP-0103', 'Coca-Cola Tofu 250g', 'Coca-Cola', 8, 'veg', 3.00),
(1526, 'SQP-0006', 'Nestlé Cheddar Cheese 1kg', 'Nestlé', 3, 'veg', 2.00),
(1527, 'SQP-0126', 'Oatly Chicken Breast Fillets 500g', 'Oatly', 1, 'halal', 4.00),
(1528, 'SQP-0120', 'Ben & Jerry\'s Sparkling Water 750g', 'Ben & Jerry\'s', 8, 'halal', 1.00),
(1529, 'SQP-0058', 'Warburtons Basmati Rice 12 pack', 'Warburtons', 3, 'halal', 1.00),
(1530, 'SQP-0118', 'Hovis Free-range Eggs 4 pack', 'Hovis', 2, 'veg', 2.00),
(1531, 'SQP-0001', 'Pepsi Co-op Lentils 500ml', 'Pepsi', 3, 'halal', 1.00),
(1532, 'SQP-0078', 'Yeo Valley Butter 2L', 'Yeo Valley', 3, 'veg', 3.00),
(1533, 'SQP-0112', 'Dolmio Salmon Fillets 250g', 'Dolmio', 2, 'halal', 5.00),
(1534, 'SQP-0135', 'Arla Veggie Burger 6 pack', 'Arla', 10, 'vegan', 3.00),
(1535, 'SQP-0058', 'Warburtons Basmati Rice 12 pack', 'Warburtons', 10, 'halal', 2.00),
(1536, 'SQP-0078', 'Yeo Valley Butter 2L', 'Yeo Valley', 8, 'veg', 3.00),
(1537, 'SQP-0063', 'Pepsi Tofu 2L', 'Pepsi', 8, 'vegan', 3.00),
(1538, 'SQP-0064', 'Linda McCartney Bananas 750g', 'Linda McCartney', 1, 'veg', 2.00),
(1539, 'SQP-0015', 'Kellogg\'s Veggie Burger 500g', 'Kellogg\'s', 1, 'veg', 3.00),
(1540, 'SQP-0021', 'Yeo Valley Cheddar Cheese 6 pack', 'Yeo Valley', 5, 'veg', 3.00),
(1541, 'SQP-0095', 'Napolina Bread Loaf 250g', 'Napolina', 4, 'veg', 2.00),
(1542, 'SQP-0108', 'Linda McCartney Salmon Fillets 6 pack', 'Linda McCartney', 6, 'halal', 8.00),
(1543, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 5, 'veg', 3.00),
(1544, 'SQP-0018', 'Quorn Tofu 1L', 'Quorn', 4, 'veg', 2.00),
(1545, 'SQP-0080', 'Yeo Valley Cola Soft Drink Family Size', 'Yeo Valley', 4, 'veg', 1.00),
(1546, 'SQP-0068', 'Cathedral City Cola Soft Drink 6 pack', 'Cathedral City', 5, 'halal', 2.00),
(1547, 'SQP-0127', 'Hovis Wraps Family Size', 'Hovis', 10, 'vegan', 1.00),
(1548, 'SQP-0125', 'Pepsi Frozen Peas 8 pack', 'Pepsi', 7, 'halal', 2.00),
(1549, 'SQP-0038', 'Yeo Valley Bread Loaf 1kg', 'Yeo Valley', 7, 'veg', 1.00),
(1550, 'SQP-0037', 'Lurpak Free-range Eggs 500g', 'Lurpak', 7, 'veg', 2.00),
(1551, 'SQP-0048', 'Pepsi Chocolate Bar 12 pack', 'Pepsi', 7, 'veg', 2.00),
(1552, 'SQP-0029', 'Coca-Cola Olive Oil 4 pack', 'Coca-Cola', 2, 'vegan', 10.00),
(1553, 'SQP-0049', 'Hovis Ice Cream Tub 8 pack', 'Hovis', 3, 'veg', 6.00),
(1554, 'SQP-0120', 'Ben & Jerry\'s Sparkling Water 750g', 'Ben & Jerry\'s', 1, 'halal', 2.00),
(1555, 'SQP-0096', 'Napolina Bread Loaf 250g', 'Napolina', 6, 'veg', 1.00),
(1556, 'SQP-0001', 'Patak\'s Co-op Lentils 500ml', 'Patak\'s', 2, 'halal', 2.00),
(1557, 'SQP-0108', 'Linda McCartney Salmon Fillets 6 pack', 'Linda McCartney', 2, 'halal', 7.00),
(1558, 'SQP-0098', 'Heinz Butter 330ml', 'Heinz', 6, 'veg', 4.00),
(1559, 'SQP-0111', 'Evian Cheddar Cheese 2L', 'Evian', 2, 'veg', 2.00),
(1560, 'SQP-0051', 'Napolina Chocolate Bar 1L', 'Napolina', 6, 'veg', 2.00),
(1561, 'SQP-0050', 'Twinings Olive Oil 8 pack', 'Twinings', 6, 'vegan', 6.00),
(1562, 'SQP-0008', 'Dolmio Frozen Peas 2L', 'Dolmio', 7, 'halal', 2.00),
(1563, 'SQP-0011', 'John West Olive Oil 2L', 'John West', 7, 'veg', 4.00),
(1564, 'SQP-0016', 'Pepsi Lentils 1L', 'Pepsi', 5, 'veg', 1.00),
(1565, 'SQP-0087', 'Yeo Valley Greek Yogurt 500ml', 'Yeo Valley', 6, 'veg', 2.00),
(1566, 'SQP-0012', 'Tilda Butter 1L', 'Tilda', 5, 'veg', 4.00),
(1567, 'SQP-0071', 'Heinz Veggie Burger 12 pack', 'Heinz', 5, 'vegan', 3.00),
(1568, 'SQP-0017', 'Lurpak Tea Bags 4 pack', 'Lurpak', 1, 'veg', 4.00),
(1569, 'SQP-0122', 'Arla Breakfast Cereal 750g', 'Arla', 8, 'vegan', 5.00),
(1570, 'SQP-0065', 'Heinz Pasta Family Size', 'Heinz', 7, 'vegan', 2.00),
(1571, 'SQP-0128', 'Heinz Chicken Breast Fillets 6 pack', 'Heinz', 3, 'halal', 4.00),
(1572, 'SQP-0039', 'Heinz Tofu 330ml', 'Heinz', 10, 'veg', 2.00),
(1573, 'SQP-0118', 'Hovis Free-range Eggs 4 pack', 'Hovis', 6, 'veg', 4.00),
(1574, 'SQP-0021', 'Twinings Cheddar Cheese 6 pack', 'Twinings', 9, 'veg', 2.00),
(1575, 'SQP-0064', 'Linda McCartney Bananas 750g', 'Linda McCartney', 7, 'veg', 1.00),
(1576, 'SQP-0124', 'Yeo Valley Chocolate Bar 750g', 'Yeo Valley', 9, 'veg', 1.00),
(1577, 'SQP-0110', 'Quorn Greek Yogurt 250g', 'Quorn', 2, 'veg', 4.00),
(1578, 'SQP-0022', 'Quorn Tofu 4 pack', 'Quorn', 4, 'vegan', 2.00),
(1579, 'SQP-0115', 'Twinings Pasta 750g', 'Twinings', 3, 'vegan', 2.00),
(1580, 'SQP-0118', 'Hovis Free-range Eggs 4 pack', 'Hovis', 10, 'veg', 3.00),
(1581, 'SQP-0138', 'Napolina Olive Oil 6 pack', 'Napolina', 2, 'vegan', 9.00),
(1582, 'SQP-0076', 'Heinz Apples 12 pack', 'Heinz', 5, 'vegan', 3.00),
(1583, 'SQP-0066', 'Yeo Valley Chickpeas 1kg', 'Yeo Valley', 5, 'halal', 1.00),
(1584, 'SQP-0048', 'Pepsi Chocolate Bar 12 pack', 'Pepsi', 4, 'veg', 1.00),
(1585, 'SQP-0149', 'Cadbury Semi-skimmed Milk 12 pack', 'Cadbury', 4, 'veg', 2.00),
(1586, 'SQP-0065', 'Tilda Pasta Family Size', 'Tilda', 4, 'vegan', 1.00),
(1587, 'SQP-0026', 'Lurpak Sparkling Water 2kg', 'Lurpak', 8, 'halal', 2.00),
(1588, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 8, 'veg', 2.00),
(1589, 'SQP-0115', 'Twinings Pasta 750g', 'Twinings', 6, 'vegan', 1.00),
(1590, 'SQP-0060', 'Linda McCartney Bread Loaf 750g', 'Linda McCartney', 2, 'veg', 1.00),
(1591, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 4, 'veg', 3.00),
(1592, 'SQP-0132', 'Evian Bread Loaf 2kg', 'Evian', 3, 'veg', 2.00),
(1593, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 2, 'veg', 2.00),
(1594, 'SQP-0090', 'Green Giant Bananas 2kg', 'Green Giant', 4, 'halal', 1.00),
(1595, 'SQP-0037', 'Lurpak Free-range Eggs 500g', 'Lurpak', 1, 'veg', 3.00),
(1596, 'SQP-0010', 'Warburtons Apples 500g', 'Warburtons', 10, 'halal', 2.00),
(1597, 'SQP-0003', 'Nestlé Pasta 500g', 'Nestlé', 6, 'veg', 2.00),
(1598, 'SQP-0048', 'Pepsi Chocolate Bar 12 pack', 'Pepsi', 10, 'veg', 1.00),
(1599, 'SQP-0009', 'Tilda Frozen Peas 6 pack', 'Tilda', 8, 'vegan', 1.00),
(1600, 'SQP-0105', 'Cathedral City Tomato Passata 500g', 'Cathedral City', 2, 'veg', 2.00),
(1601, 'SQP-0040', 'Kellogg\'s Butter 1L', 'Kellogg\'s', 9, 'veg', 1.00),
(1602, 'SQP-0102', 'Cathedral City Chickpeas 2L', 'Cathedral City', 5, 'halal', 1.00),
(1603, 'SQP-0079', 'Nando\'s Tomato Passata 2L', 'Nando\'s', 7, 'veg', 2.00),
(1604, 'SQP-0146', 'Walkers Olive Oil 250g', 'Walkers', 6, 'vegan', 5.00),
(1605, 'SQP-0094', 'Yeo Valley Apples 4 pack', 'Yeo Valley', 4, 'veg', 2.00),
(1606, 'SQP-0053', 'Kellogg\'s Tofu 1kg', 'Kellogg\'s', 1, 'vegan', 2.00),
(1607, 'SQP-0109', 'Pepsi Tofu Family Size', 'Pepsi', 2, 'vegan', 4.00),
(1608, 'SQP-0148', 'Ben & Jerry\'s Greek Yogurt 500ml', 'Ben & Jerry\'s', 6, 'veg', 2.00),
(1609, 'SQP-0034', 'Patak\'s Cheddar Cheese 500ml', 'Patak\'s', 1, 'veg', 2.00),
(1610, 'SQP-0102', 'Cathedral City Chickpeas 2L', 'Cathedral City', 2, 'halal', 2.00),
(1611, 'SQP-0130', 'Volvic Bananas 2L', 'Volvic', 3, 'vegan', 2.00),
(1612, 'SQP-0042', 'Quorn Salmon Fillets 2L', 'Quorn', 9, 'halal', 5.00),
(1613, 'SQP-0028', 'Walkers Basmati Rice 1kg', 'Walkers', 7, 'halal', 3.00),
(1614, 'SQP-0078', 'Yeo Valley Butter 2L', 'Yeo Valley', 3, 'veg', 3.00),
(1615, 'SQP-0124', 'Yeo Valley Chocolate Bar 750g', 'Yeo Valley', 6, 'veg', 1.00),
(1616, 'SQP-0023', 'Ben & Jerry\'s Pasta 2kg', 'Ben & Jerry\'s', 10, 'vegan', 2.00),
(1617, 'SQP-0057', 'Hovis Wraps 12 pack', 'Hovis', 10, 'veg', 1.00),
(1618, 'SQP-0122', 'Arla Breakfast Cereal 750g', 'Arla', 3, 'vegan', 3.00),
(1619, 'SQP-0103', 'Patak\'s Tofu 250g', 'Patak\'s', 9, 'veg', 2.00),
(1620, 'SQP-0032', 'John West Chicken Breast Fillets 8 pack', 'John West', 3, 'halal', 4.00),
(1621, 'SQP-0011', 'John West Olive Oil 2L', 'John West', 9, 'veg', 8.00),
(1622, 'SQP-0083', 'Ben & Jerry\'s Cola Soft Drink 750g', 'Ben & Jerry\'s', 2, 'halal', 2.00),
(1623, 'SQP-0141', 'Arla Bread Loaf 250g', 'Arla', 5, 'veg', 2.00),
(1624, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 4, 'veg', 2.00),
(1625, 'SQP-0115', 'Twinings Pasta 750g', 'Twinings', 9, 'vegan', 1.00),
(1626, 'SQP-0001', 'Nando\'s Co-op Lentils 500ml', 'Nando\'s', 10, 'halal', 2.00),
(1627, 'SQP-0061', 'Walkers Semi-skimmed Milk 4 pack', 'Walkers', 8, 'veg', 2.00),
(1628, 'SQP-0046', 'Twinings Basmati Rice 12 pack', 'Twinings', 8, 'vegan', 2.00),
(1629, 'SQP-0033', 'Ben & Jerry\'s Sparkling Water Family Size', 'Ben & Jerry\'s', 6, 'halal', 1.00),
(1630, 'SQP-0114', 'Nestlé Lentils 330ml', 'Nestlé', 9, 'vegan', 1.00),
(1631, 'SQP-0011', 'John West Olive Oil 2L', 'John West', 3, 'veg', 4.00),
(1632, 'SQP-0131', 'Linda McCartney Bread Loaf 8 pack', 'Linda McCartney', 2, 'veg', 1.00),
(1633, 'SQP-0097', 'Warburtons Bread Loaf Family Size', 'Warburtons', 3, 'veg', 1.00),
(1634, 'SQP-0029', 'Coca-Cola Olive Oil 4 pack', 'Coca-Cola', 4, 'vegan', 5.00),
(1635, 'SQP-0074', 'Ben & Jerry\'s Chocolate Bar 500g', 'Ben & Jerry\'s', 3, 'veg', 1.00),
(1636, 'SQP-0017', 'Lurpak Tea Bags 4 pack', 'Lurpak', 6, 'veg', 4.00),
(1637, 'SQP-0041', 'Cadbury Breakfast Cereal 8 pack', 'Cadbury', 6, 'vegan', 5.00),
(1638, 'SQP-0117', 'Heinz Tea Bags 500g', 'Heinz', 3, 'veg', 3.00),
(1639, 'SQP-0054', 'Cadbury Pasta 1kg', 'Cadbury', 10, 'veg', 2.00),
(1640, 'SQP-0061', 'Walkers Semi-skimmed Milk 4 pack', 'Walkers', 6, 'veg', 1.00),
(1641, 'SQP-0047', 'Yeo Valley Tea Bags 330ml', 'Yeo Valley', 7, 'halal', 3.00),
(1642, 'SQP-0084', 'Walkers Tofu 2kg', 'Walkers', 7, 'vegan', 2.00),
(1643, 'SQP-0030', 'Walkers Semi-skimmed Milk 500ml', 'Walkers', 9, 'veg', 1.00),
(1644, 'SQP-0116', 'Arla Bread Loaf 2kg', 'Arla', 9, 'veg', 1.00),
(1645, 'SQP-0065', 'Linda McCartney Pasta Family Size', 'Linda McCartney', 9, 'vegan', 2.00),
(1646, 'SQP-0096', 'Napolina Bread Loaf 250g', 'Napolina', 5, 'veg', 2.00),
(1647, 'SQP-0148', 'Ben & Jerry\'s Greek Yogurt 500ml', 'Ben & Jerry\'s', 3, 'veg', 1.00),
(1648, 'SQP-0114', 'Volvic Lentils 330ml', 'Volvic', 4, 'vegan', 1.00),
(1649, 'SQP-0076', 'Heinz Apples 12 pack', 'Heinz', 9, 'vegan', 2.00),
(1650, 'SQP-0081', 'Cathedral City Cheddar Cheese 330ml', 'Cathedral City', 1, 'veg', 4.00),
(1651, 'SQP-0039', 'Warburtons Tofu 330ml', 'Warburtons', 5, 'veg', 3.00),
(1652, 'SQP-0107', 'Patak\'s Pasta 330ml', 'Patak\'s', 9, 'vegan', 1.00),
(1653, 'SQP-0034', 'Green Giant Cheddar Cheese 500ml', 'Green Giant', 8, 'veg', 2.00),
(1654, 'SQP-0006', 'Nestlé Cheddar Cheese 1kg', 'Nestlé', 1, 'veg', 2.00),
(1655, 'SQP-0078', 'Yeo Valley Butter 2L', 'Yeo Valley', 2, 'veg', 3.00),
(1656, 'SQP-0058', 'Warburtons Basmati Rice 12 pack', 'Warburtons', 7, 'halal', 4.00),
(1657, 'SQP-0035', 'Oatly Whole Milk 500g', 'Oatly', 4, 'veg', 2.00),
(1658, 'SQP-0041', 'Cadbury Breakfast Cereal 8 pack', 'Cadbury', 3, 'vegan', 2.00),
(1659, 'SQP-0039', 'Cathedral City Tofu 330ml', 'Cathedral City', 8, 'veg', 2.00),
(1660, 'SQP-0070', 'Yeo Valley Bananas 250g', 'Yeo Valley', 7, 'veg', 1.00),
(1661, 'SQP-0015', 'Kellogg\'s Veggie Burger 500g', 'Kellogg\'s', 9, 'veg', 5.00),
(1662, 'SQP-0149', 'Cadbury Semi-skimmed Milk 12 pack', 'Cadbury', 8, 'veg', 2.00),
(1663, 'SQP-0127', 'Hovis Wraps Family Size', 'Hovis', 4, 'vegan', 1.00),
(1664, 'SQP-0012', 'Tilda Butter 1L', 'Tilda', 1, 'veg', 3.00),
(1665, 'SQP-0048', 'Pepsi Chocolate Bar 12 pack', 'Pepsi', 4, 'veg', 1.00),
(1666, 'SQP-0004', 'Nestlé Tomato Passata 2L', 'Nestlé', 10, 'veg', 1.00),
(1667, 'SQP-0037', 'Lurpak Free-range Eggs 500g', 'Lurpak', 7, 'veg', 3.00),
(1668, 'SQP-0130', 'Volvic Bananas 2L', 'Volvic', 7, 'vegan', 1.00),
(1669, 'SQP-0131', 'Linda McCartney Bread Loaf 8 pack', 'Linda McCartney', 5, 'veg', 1.00),
(1670, 'SQP-0123', 'Walkers Chicken Breast Fillets 250g', 'Walkers', 9, 'halal', 4.00),
(1671, 'SQP-0120', 'Ben & Jerry\'s Sparkling Water 750g', 'Ben & Jerry\'s', 2, 'halal', 3.00),
(1672, 'SQP-0045', 'Kellogg\'s Sparkling Water 8 pack', 'Kellogg\'s', 4, 'veg', 3.00),
(1673, 'SQP-0060', 'Linda McCartney Bread Loaf 750g', 'Linda McCartney', 1, 'veg', 1.00),
(1674, 'SQP-0014', 'Arla Bananas 330ml', 'Arla', 5, 'halal', 2.00),
(1675, 'SQP-0134', 'Kellogg\'s Cheddar Cheese 1L', 'Kellogg\'s', 5, 'veg', 2.00),
(1676, 'SQP-0022', 'Quorn Tofu 4 pack', 'Quorn', 9, 'vegan', 2.00),
(1677, 'SQP-0061', 'Walkers Semi-skimmed Milk 4 pack', 'Walkers', 4, 'veg', 2.00),
(1678, 'SQP-0050', 'Twinings Olive Oil 8 pack', 'Twinings', 7, 'vegan', 5.00),
(1679, 'SQP-0098', 'Heinz Butter 330ml', 'Heinz', 9, 'veg', 3.00),
(1680, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 1, 'veg', 1.00),
(1681, 'SQP-0147', 'Cathedral City Beef Mince 500ml', 'Cathedral City', 5, 'halal', 9.00),
(1682, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 2, 'veg', 1.00),
(1683, 'SQP-0038', 'Cadbury Bread Loaf 1kg', 'Cadbury', 1, 'veg', 1.00),
(1684, 'SQP-0042', 'Quorn Salmon Fillets 2L', 'Quorn', 6, 'halal', 9.00),
(1685, 'SQP-0008', 'Dolmio Frozen Peas 2L', 'Dolmio', 1, 'halal', 1.00),
(1686, 'SQP-0018', 'Lurpak Tofu 1L', 'Lurpak', 1, 'veg', 2.00),
(1687, 'SQP-0094', 'Yeo Valley Apples 4 pack', 'Yeo Valley', 4, 'veg', 3.00),
(1688, 'SQP-0017', 'Lurpak Tea Bags 4 pack', 'Lurpak', 7, 'veg', 2.00),
(1689, 'SQP-0053', 'Kellogg\'s Tofu 1kg', 'Kellogg\'s', 2, 'vegan', 2.00),
(1690, 'SQP-0074', 'Ben & Jerry\'s Chocolate Bar 500g', 'Ben & Jerry\'s', 8, 'veg', 1.00),
(1691, 'SQP-0053', 'Kellogg\'s Tofu 1kg', 'Kellogg\'s', 5, 'vegan', 3.00),
(1692, 'SQP-0067', 'Arla Apples Family Size', 'Arla', 1, 'vegan', 2.00),
(1693, 'SQP-0013', 'Nando\'s Chocolate Bar 8 pack', 'Nando\'s', 6, 'veg', 2.00),
(1694, 'SQP-0129', 'Cathedral City Semi-skimmed Milk 12 pack', 'Cathedral City', 8, 'veg', 2.00),
(1695, 'SQP-0008', 'Dolmio Frozen Peas 2L', 'Dolmio', 7, 'halal', 1.00),
(1696, 'SQP-0026', 'Lurpak Sparkling Water 2kg', 'Lurpak', 6, 'halal', 1.00),
(1697, 'SQP-0138', 'Napolina Olive Oil 6 pack', 'Napolina', 10, 'vegan', 4.00),
(1698, 'SQP-0148', 'Birds Eye Greek Yogurt 500ml', 'Birds Eye', 5, 'veg', 1.00),
(1699, 'SQP-0135', 'Princes Veggie Burger 6 pack', 'Princes', 4, 'vegan', 2.00),
(1700, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 6, 'veg', 2.00),
(1701, 'SQP-0048', 'Pepsi Chocolate Bar 12 pack', 'Pepsi', 8, 'veg', 2.00),
(1702, 'SQP-0067', 'Twinings Apples Family Size', 'Twinings', 10, 'vegan', 3.00),
(1703, 'SQP-0055', 'Green Giant Cola Soft Drink Family Size', 'Green Giant', 4, 'vegan', 1.00),
(1704, 'SQP-0021', 'Heinz Cheddar Cheese 6 pack', 'Heinz', 8, 'veg', 5.00),
(1705, 'SQP-0027', 'John West Tofu 500ml', 'John West', 6, 'vegan', 3.00),
(1706, 'SQP-0102', 'Cathedral City Chickpeas 2L', 'Cathedral City', 2, 'halal', 1.00),
(1707, 'SQP-0096', 'Napolina Bread Loaf 250g', 'Napolina', 4, 'veg', 2.00),
(1708, 'SQP-0140', 'Ben & Jerry\'s Butter 500g', 'Ben & Jerry\'s', 9, 'veg', 1.00),
(1709, 'SQP-0118', 'Hovis Free-range Eggs 4 pack', 'Hovis', 3, 'veg', 3.00),
(1710, 'SQP-0009', 'Tilda Frozen Peas 6 pack', 'Tilda', 6, 'vegan', 2.00),
(1711, 'SQP-0040', 'Walkers Butter 1L', 'Walkers', 8, 'veg', 3.00),
(1712, 'SQP-0044', 'Ben & Jerry\'s Semi-skimmed Milk 2L', 'Ben & Jerry\'s', 8, 'veg', 2.00),
(1713, 'SQP-0149', 'Cadbury Semi-skimmed Milk 12 pack', 'Cadbury', 4, 'veg', 2.00),
(1714, 'SQP-0061', 'Walkers Semi-skimmed Milk 4 pack', 'Walkers', 9, 'veg', 2.00),
(1715, 'SQP-0040', 'Linda McCartney Butter 1L', 'Linda McCartney', 3, 'veg', 4.00),
(1716, 'SQP-0134', 'Kellogg\'s Cheddar Cheese 1L', 'Kellogg\'s', 6, 'veg', 3.00),
(1717, 'SQP-0049', 'Hovis Ice Cream Tub 8 pack', 'Hovis', 5, 'veg', 6.00),
(1718, 'SQP-0043', 'Twinings Bananas 750g', 'Twinings', 2, 'halal', 1.00),
(1719, 'SQP-0038', 'Coca-Cola Bread Loaf 1kg', 'Coca-Cola', 5, 'veg', 2.00),
(1720, 'SQP-0071', 'Heinz Veggie Burger 12 pack', 'Heinz', 4, 'vegan', 2.00),
(1721, 'SQP-0072', 'Green Giant Olive Oil 8 pack', 'Green Giant', 4, 'vegan', 9.00),
(1722, 'SQP-0009', 'Tilda Frozen Peas 6 pack', 'Tilda', 1, 'vegan', 2.00),
(1723, 'SQP-0057', 'Hovis Wraps 12 pack', 'Hovis', 9, 'veg', 3.00),
(1724, 'SQP-0119', 'Kellogg\'s Co-op Chickpeas 6 pack', 'Kellogg\'s', 1, 'vegan', 1.00),
(1725, 'SQP-0104', 'Yeo Valley Breakfast Cereal 2L', 'Yeo Valley', 1, 'veg', 4.00),
(1726, 'SQP-0147', 'Cathedral City Beef Mince 500ml', 'Cathedral City', 10, 'halal', 8.00),
(1727, 'SQP-0059', 'Linda McCartney Chocolate Bar 500ml', 'Linda McCartney', 10, 'veg', 1.00),
(1728, 'SQP-0032', 'John West Chicken Breast Fillets 8 pack', 'John West', 8, 'halal', 6.00),
(1729, 'SQP-0026', 'Lurpak Sparkling Water 2kg', 'Lurpak', 7, 'halal', 2.00),
(1730, 'SQP-0041', 'Cadbury Breakfast Cereal 8 pack', 'Cadbury', 5, 'vegan', 5.00),
(1731, 'SQP-0117', 'Heinz Tea Bags 500g', 'Heinz', 1, 'veg', 4.00),
(1732, 'SQP-0133', 'Patak\'s Pasta 8 pack', 'Patak\'s', 3, 'veg', 3.00),
(1733, 'SQP-0003', 'Nestlé Pasta 500g', 'Nestlé', 7, 'veg', 2.00),
(1734, 'SQP-0010', 'Birds Eye Apples 500g', 'Birds Eye', 5, 'halal', 2.00),
(1735, 'SQP-0052', 'Twinings Veggie Burger 1L', 'Twinings', 9, 'veg', 3.00),
(1736, 'SQP-0117', 'Heinz Tea Bags 500g', 'Heinz', 9, 'veg', 3.00),
(1737, 'SQP-0132', 'Evian Bread Loaf 2kg', 'Evian', 1, 'veg', 2.00),
(1738, 'SQP-0134', 'Kellogg\'s Cheddar Cheese 1L', 'Kellogg\'s', 6, 'veg', 3.00),
(1739, 'SQP-0054', 'Cadbury Pasta 1kg', 'Cadbury', 3, 'veg', 1.00),
(1740, 'SQP-0092', 'Volvic Whole Milk 12 pack', 'Volvic', 1, 'veg', 2.00),
(1741, 'SQP-0103', 'Pepsi Tofu 250g', 'Pepsi', 1, 'veg', 2.00),
(1742, 'SQP-0108', 'Linda McCartney Salmon Fillets 6 pack', 'Linda McCartney', 6, 'halal', 7.00),
(1743, 'SQP-0058', 'Warburtons Basmati Rice 12 pack', 'Warburtons', 5, 'halal', 5.00),
(1744, 'SQP-0057', 'Hovis Wraps 12 pack', 'Hovis', 7, 'veg', 1.00),
(1745, 'SQP-0034', 'Heinz Cheddar Cheese 500ml', 'Heinz', 2, 'veg', 4.00),
(1746, 'SQP-0121', 'Volvic Chocolate Bar 4 pack', 'Volvic', 9, 'veg', 1.00),
(1747, 'SQP-0091', 'Cathedral City Wraps 1kg', 'Cathedral City', 7, 'veg', 2.00),
(1748, 'SQP-0141', 'Arla Bread Loaf 250g', 'Arla', 3, 'veg', 2.00),
(1749, 'SQP-0091', 'Quorn Wraps 1kg', 'Quorn', 4, 'veg', 2.00),
(1750, 'SQP-0065', 'Lurpak Pasta Family Size', 'Lurpak', 7, 'vegan', 3.00),
(1751, 'SQP-0001', 'Linda McCartney Co-op Lentils 500ml', 'Linda McCartney', 5, 'halal', 2.00),
(1752, 'SQP-0083', 'Ben & Jerry\'s Cola Soft Drink 750g', 'Ben & Jerry\'s', 8, 'halal', 2.00),
(1753, 'SQP-0022', 'Quorn Tofu 4 pack', 'Quorn', 6, 'vegan', 2.00),
(1754, 'SQP-0099', 'Green Giant Tomato Sauce 750g', 'Green Giant', 1, 'vegan', 2.00),
(1755, 'SQP-0084', 'Walkers Tofu 2kg', 'Walkers', 3, 'vegan', 3.00),
(1756, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 1, 'veg', 1.00),
(1757, 'SQP-0019', 'Cadbury Tomato Sauce 8 pack', 'Cadbury', 5, 'vegan', 1.00),
(1758, 'SQP-0149', 'Cadbury Semi-skimmed Milk 12 pack', 'Cadbury', 3, 'veg', 1.00),
(1759, 'SQP-0116', 'Arla Bread Loaf 2kg', 'Arla', 6, 'veg', 1.00),
(1760, 'SQP-0104', 'Yeo Valley Breakfast Cereal 2L', 'Yeo Valley', 9, 'veg', 3.00),
(1761, 'SQP-0024', 'Hovis Cheddar Cheese Family Size', 'Hovis', 9, 'veg', 5.00),
(1762, 'SQP-0051', 'Napolina Chocolate Bar 1L', 'Napolina', 8, 'veg', 2.00),
(1763, 'SQP-0021', 'Arla Cheddar Cheese 6 pack', 'Arla', 8, 'veg', 3.00),
(1764, 'SQP-0143', 'Walkers Co-op Pasta 4 pack', 'Walkers', 2, 'vegan', 1.00),
(1765, 'SQP-0036', 'Quorn Wraps 4 pack', 'Quorn', 8, 'veg', 1.00),
(1766, 'SQP-0124', 'Yeo Valley Chocolate Bar 750g', 'Yeo Valley', 8, 'veg', 2.00),
(1767, 'SQP-0064', 'Linda McCartney Bananas 750g', 'Linda McCartney', 8, 'veg', 2.00),
(1768, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 3, 'veg', 3.00),
(1769, 'SQP-0145', 'Twinings Salmon Fillets 1kg', 'Twinings', 8, 'halal', 8.00),
(1770, 'SQP-0096', 'Napolina Bread Loaf 250g', 'Napolina', 7, 'veg', 1.00),
(1771, 'SQP-0047', 'Yeo Valley Tea Bags 330ml', 'Yeo Valley', 6, 'halal', 4.00),
(1772, 'SQP-0006', 'Nestlé Cheddar Cheese 1kg', 'Nestlé', 10, 'veg', 2.00),
(1773, 'SQP-0025', 'Lurpak Cheddar Cheese 2kg', 'Lurpak', 9, 'veg', 3.00),
(1774, 'SQP-0009', 'Tilda Frozen Peas 6 pack', 'Tilda', 4, 'vegan', 2.00),
(1775, 'SQP-0087', 'Yeo Valley Greek Yogurt 500ml', 'Yeo Valley', 2, 'veg', 4.00),
(1776, 'SQP-0088', 'John West Co-op Tofu 500g', 'John West', 8, 'veg', 4.00),
(1777, 'SQP-0054', 'Cadbury Pasta 1kg', 'Cadbury', 5, 'veg', 2.00),
(1778, 'SQP-0065', 'Nestlé Pasta Family Size', 'Nestlé', 9, 'vegan', 1.00),
(1779, 'SQP-0075', 'Nestlé Tomato Sauce 12 pack', 'Nestlé', 6, 'vegan', 3.00),
(1780, 'SQP-0086', 'John West Basmati Rice Family Size', 'John West', 9, 'vegan', 6.00),
(1781, 'SQP-0089', 'Cathedral City Butter 8 pack', 'Cathedral City', 4, 'veg', 2.00),
(1782, 'SQP-0085', 'Linda McCartney Tomato Passata 500g', 'Linda McCartney', 4, 'veg', 2.00),
(1783, 'SQP-0033', 'Ben & Jerry\'s Sparkling Water Family Size', 'Ben & Jerry\'s', 10, 'halal', 2.00),
(1784, 'SQP-0011', 'John West Olive Oil 2L', 'John West', 7, 'veg', 8.00),
(1785, 'SQP-0140', 'Ben & Jerry\'s Butter 500g', 'Ben & Jerry\'s', 10, 'veg', 2.00),
(1786, 'SQP-0028', 'Walkers Basmati Rice 1kg', 'Walkers', 1, 'halal', 2.00),
(1787, 'SQP-0016', 'Arla Lentils 1L', 'Arla', 9, 'veg', 2.00),
(1788, 'SQP-0097', 'Evian Bread Loaf Family Size', 'Evian', 10, 'veg', 1.00),
(1789, 'SQP-0022', 'Quorn Tofu 4 pack', 'Quorn', 4, 'vegan', 2.00),
(1790, 'SQP-0045', 'Kellogg\'s Sparkling Water 8 pack', 'Kellogg\'s', 2, 'veg', 1.00),
(1791, 'SQP-0108', 'Linda McCartney Salmon Fillets 6 pack', 'Linda McCartney', 2, 'halal', 9.00),
(1792, 'SQP-0095', 'Napolina Bread Loaf 250g', 'Napolina', 3, 'veg', 2.00),
(1793, 'SQP-0067', 'Coca-Cola Apples Family Size', 'Coca-Cola', 5, 'vegan', 1.00),
(1794, 'SQP-0082', 'Kellogg\'s Greek Yogurt 1kg', 'Kellogg\'s', 1, 'veg', 3.00),
(1795, 'SQP-0014', 'Arla Bananas 330ml', 'Arla', 8, 'halal', 1.00),
(1796, 'SQP-0031', 'Walkers Lentils 8 pack', 'Walkers', 7, 'halal', 2.00),
(1797, 'SQP-0115', 'Twinings Pasta 750g', 'Twinings', 2, 'vegan', 1.00),
(1798, 'SQP-0040', 'Patak\'s Butter 1L', 'Patak\'s', 8, 'veg', 4.00),
(1799, 'SQP-0027', 'John West Tofu 500ml', 'John West', 2, 'vegan', 2.00),
(1800, 'SQP-0039', 'Kellogg\'s Tofu 330ml', 'Kellogg\'s', 1, 'veg', 2.00),
(1801, 'SQP-0032', 'John West Chicken Breast Fillets 8 pack', 'John West', 2, 'halal', 4.00),
(1802, 'SQP-0034', 'Ben & Jerry\'s Cheddar Cheese 500ml', 'Ben & Jerry\'s', 8, 'veg', 2.00),
(1803, 'SQP-0063', 'Oatly Tofu 2L', 'Oatly', 8, 'vegan', 2.00),
(1804, 'SQP-0013', 'Oatly Chocolate Bar 8 pack', 'Oatly', 6, 'veg', 1.00),
(1805, 'SQP-0022', 'Quorn Tofu 4 pack', 'Quorn', 5, 'vegan', 3.00),
(1806, 'SQP-0118', 'Hovis Free-range Eggs 4 pack', 'Hovis', 5, 'veg', 3.00),
(1807, 'SQP-0009', 'Tilda Frozen Peas 6 pack', 'Tilda', 1, 'vegan', 1.00),
(1808, 'SQP-0021', 'John West Cheddar Cheese 6 pack', 'John West', 7, 'veg', 3.00),
(1809, 'SQP-0043', 'Twinings Bananas 750g', 'Twinings', 8, 'halal', 2.00),
(1810, 'SQP-0095', 'Napolina Bread Loaf 250g', 'Napolina', 10, 'veg', 2.00),
(1811, 'SQP-0043', 'Twinings Bananas 750g', 'Twinings', 3, 'halal', 2.00),
(1812, 'SQP-0093', 'Coca-Cola Free-range Eggs 500ml', 'Coca-Cola', 3, 'veg', 3.00),
(1813, 'SQP-0123', 'Walkers Chicken Breast Fillets 250g', 'Walkers', 7, 'halal', 8.00),
(1814, 'SQP-0070', 'Yeo Valley Bananas 250g', 'Yeo Valley', 10, 'veg', 2.00),
(1815, 'SQP-0016', 'Pepsi Lentils 1L', 'Pepsi', 10, 'veg', 2.00),
(1816, 'SQP-0086', 'John West Basmati Rice Family Size', 'John West', 10, 'vegan', 4.00),
(1817, 'SQP-0039', 'Volvic Tofu 330ml', 'Volvic', 10, 'veg', 4.00),
(1818, 'SQP-0110', 'Quorn Greek Yogurt 250g', 'Quorn', 4, 'veg', 2.00),
(1819, 'SQP-0060', 'Linda McCartney Bread Loaf 750g', 'Linda McCartney', 8, 'veg', 1.00),
(1820, 'SQP-0083', 'Ben & Jerry\'s Cola Soft Drink 750g', 'Ben & Jerry\'s', 5, 'halal', 1.00),
(1821, 'SQP-0011', 'John West Olive Oil 2L', 'John West', 5, 'veg', 9.00),
(1822, 'SQP-0038', 'John West Bread Loaf 1kg', 'John West', 5, 'veg', 2.00),
(1823, 'SQP-0128', 'Heinz Chicken Breast Fillets 6 pack', 'Heinz', 6, 'halal', 7.00),
(1824, 'SQP-0142', 'Yeo Valley Ice Cream Tub 1L', 'Yeo Valley', 8, 'veg', 5.00),
(1825, 'SQP-0060', 'Linda McCartney Bread Loaf 750g', 'Linda McCartney', 5, 'veg', 2.00),
(1826, 'SQP-0120', 'Ben & Jerry\'s Sparkling Water 750g', 'Ben & Jerry\'s', 4, 'halal', 3.00),
(1827, 'SQP-0003', 'Nestlé Pasta 500g', 'Nestlé', 7, 'veg', 1.00),
(1828, 'SQP-0138', 'Napolina Olive Oil 6 pack', 'Napolina', 6, 'vegan', 8.00),
(1829, 'SQP-0102', 'Cathedral City Chickpeas 2L', 'Cathedral City', 10, 'halal', 2.00),
(1830, 'SQP-0134', 'Kellogg\'s Cheddar Cheese 1L', 'Kellogg\'s', 6, 'veg', 4.00),
(1831, 'SQP-0052', 'Twinings Veggie Burger 1L', 'Twinings', 4, 'veg', 2.00),
(1832, 'SQP-0047', 'Yeo Valley Tea Bags 330ml', 'Yeo Valley', 5, 'halal', 3.00),
(1833, 'SQP-0092', 'Volvic Whole Milk 12 pack', 'Volvic', 7, 'veg', 1.00),
(1834, 'SQP-0064', 'Linda McCartney Bananas 750g', 'Linda McCartney', 1, 'veg', 2.00),
(1835, 'SQP-0096', 'Napolina Bread Loaf 250g', 'Napolina', 2, 'veg', 2.00),
(1836, 'SQP-0021', 'Ben & Jerry\'s Cheddar Cheese 6 pack', 'Ben & Jerry\'s', 3, 'veg', 2.00),
(1837, 'SQP-0089', 'Cathedral City Butter 8 pack', 'Cathedral City', 5, 'veg', 2.00),
(1838, 'SQP-0025', 'Lurpak Cheddar Cheese 2kg', 'Lurpak', 1, 'veg', 3.00),
(1839, 'SQP-0125', 'Pepsi Frozen Peas 8 pack', 'Pepsi', 10, 'halal', 2.00),
(1840, 'SQP-0072', 'Green Giant Olive Oil 8 pack', 'Green Giant', 7, 'vegan', 5.00),
(1841, 'SQP-0034', 'Ben & Jerry\'s Cheddar Cheese 500ml', 'Ben & Jerry\'s', 5, 'veg', 5.00),
(1842, 'SQP-0052', 'Twinings Veggie Burger 1L', 'Twinings', 3, 'veg', 2.00),
(1843, 'SQP-0014', 'Arla Bananas 330ml', 'Arla', 1, 'halal', 2.00),
(1844, 'SQP-0125', 'Pepsi Frozen Peas 8 pack', 'Pepsi', 2, 'halal', 3.00),
(1845, 'SQP-0031', 'Walkers Lentils 8 pack', 'Walkers', 2, 'halal', 2.00),
(1846, 'SQP-0060', 'Linda McCartney Bread Loaf 750g', 'Linda McCartney', 2, 'veg', 2.00),
(1847, 'SQP-0101', 'Princes Chickpeas 2kg', 'Princes', 3, 'halal', 1.00),
(1848, 'SQP-0095', 'Napolina Bread Loaf 250g', 'Napolina', 4, 'veg', 1.00),
(1849, 'SQP-0045', 'Kellogg\'s Sparkling Water 8 pack', 'Kellogg\'s', 1, 'veg', 3.00),
(1850, 'SQP-0016', 'Volvic Lentils 1L', 'Volvic', 9, 'veg', 2.00),
(1851, 'SQP-0067', 'Tilda Apples Family Size', 'Tilda', 9, 'vegan', 3.00),
(1852, 'SQP-0015', 'Kellogg\'s Veggie Burger 500g', 'Kellogg\'s', 2, 'veg', 2.00),
(1853, 'SQP-0051', 'Napolina Chocolate Bar 1L', 'Napolina', 5, 'veg', 2.00),
(1854, 'SQP-0027', 'John West Tofu 500ml', 'John West', 8, 'vegan', 3.00),
(1855, 'SQP-0100', 'Linda McCartney Tomato Passata 750g', 'Linda McCartney', 2, 'veg', 2.00),
(1856, 'SQP-0044', 'Ben & Jerry\'s Semi-skimmed Milk 2L', 'Ben & Jerry\'s', 8, 'veg', 1.00),
(1857, 'SQP-0004', 'Kellogg\'s Tomato Passata 2L', 'Kellogg\'s', 8, 'veg', 1.00),
(1858, 'SQP-0010', 'Birds Eye Apples 500g', 'Birds Eye', 3, 'halal', 2.00),
(1859, 'SQP-0020', 'Tilda Chicken Breast Fillets 6 pack', 'Tilda', 10, 'halal', 7.00),
(1860, 'SQP-0115', 'Twinings Pasta 750g', 'Twinings', 2, 'vegan', 3.00),
(1861, 'SQP-0006', 'Nestlé Cheddar Cheese 1kg', 'Nestlé', 2, 'veg', 4.00),
(1862, 'SQP-0083', 'Ben & Jerry\'s Cola Soft Drink 750g', 'Ben & Jerry\'s', 4, 'halal', 2.00),
(1863, 'SQP-0037', 'Lurpak Free-range Eggs 500g', 'Lurpak', 6, 'veg', 2.00),
(1864, 'SQP-0047', 'Yeo Valley Tea Bags 330ml', 'Yeo Valley', 8, 'halal', 3.00),
(1865, 'SQP-0113', 'Cathedral City Tomato Sauce 250g', 'Cathedral City', 3, 'veg', 2.00),
(1866, 'SQP-0064', 'Linda McCartney Bananas 750g', 'Linda McCartney', 3, 'veg', 1.00),
(1867, 'SQP-0076', 'Heinz Apples 12 pack', 'Heinz', 6, 'vegan', 3.00),
(1868, 'SQP-0126', 'Lurpak Chicken Breast Fillets 500g', 'Lurpak', 2, 'halal', 6.00),
(1869, 'SQP-0030', 'Walkers Semi-skimmed Milk 500ml', 'Walkers', 3, 'veg', 1.00),
(1870, 'SQP-0055', 'Green Giant Cola Soft Drink Family Size', 'Green Giant', 9, 'vegan', 2.00),
(1871, 'SQP-0031', 'Walkers Lentils 8 pack', 'Walkers', 5, 'halal', 2.00),
(1872, 'SQP-0111', 'Evian Cheddar Cheese 2L', 'Evian', 5, 'veg', 4.00),
(1873, 'SQP-0025', 'Lurpak Cheddar Cheese 2kg', 'Lurpak', 7, 'veg', 2.00),
(1874, 'SQP-0015', 'Kellogg\'s Veggie Burger 500g', 'Kellogg\'s', 5, 'veg', 2.00),
(1875, 'SQP-0114', 'Arla Lentils 330ml', 'Arla', 9, 'vegan', 1.00),
(1876, 'SQP-0114', 'Lurpak Lentils 330ml', 'Lurpak', 1, 'vegan', 2.00),
(1877, 'SQP-0074', 'Ben & Jerry\'s Chocolate Bar 500g', 'Ben & Jerry\'s', 3, 'veg', 1.00),
(1878, 'SQP-0105', 'Cathedral City Tomato Passata 500g', 'Cathedral City', 4, 'veg', 1.00),
(1879, 'SQP-0036', 'Coca-Cola Wraps 4 pack', 'Coca-Cola', 3, 'veg', 1.00),
(1880, 'SQP-0045', 'Kellogg\'s Sparkling Water 8 pack', 'Kellogg\'s', 4, 'veg', 1.00),
(1881, 'SQP-0127', 'Hovis Wraps Family Size', 'Hovis', 5, 'vegan', 1.00),
(1882, 'SQP-0050', 'Twinings Olive Oil 8 pack', 'Twinings', 10, 'vegan', 5.00),
(1883, 'SQP-0017', 'Lurpak Tea Bags 4 pack', 'Lurpak', 9, 'veg', 3.00),
(1884, 'SQP-0133', 'Patak\'s Pasta 8 pack', 'Patak\'s', 6, 'veg', 2.00),
(1885, 'SQP-0024', 'Hovis Cheddar Cheese Family Size', 'Hovis', 1, 'veg', 3.00),
(1886, 'SQP-0035', 'Oatly Whole Milk 500g', 'Oatly', 5, 'veg', 2.00),
(1887, 'SQP-0094', 'Yeo Valley Apples 4 pack', 'Yeo Valley', 1, 'veg', 2.00),
(1888, 'SQP-0148', 'Oatly Greek Yogurt 500ml', 'Oatly', 10, 'veg', 4.00),
(1889, 'SQP-0134', 'Kellogg\'s Cheddar Cheese 1L', 'Kellogg\'s', 8, 'veg', 4.00),
(1890, 'SQP-0031', 'Walkers Lentils 8 pack', 'Walkers', 6, 'halal', 2.00),
(1891, 'SQP-0098', 'Heinz Butter 330ml', 'Heinz', 10, 'veg', 3.00),
(1892, 'SQP-0075', 'Nestlé Tomato Sauce 12 pack', 'Nestlé', 2, 'vegan', 3.00),
(1893, 'SQP-0115', 'Twinings Pasta 750g', 'Twinings', 9, 'vegan', 1.00),
(1894, 'SQP-0035', 'Oatly Whole Milk 500g', 'Oatly', 1, 'veg', 1.00),
(1895, 'SQP-0058', 'Warburtons Basmati Rice 12 pack', 'Warburtons', 10, 'halal', 1.00),
(1896, 'SQP-0080', 'Cadbury Cola Soft Drink Family Size', 'Cadbury', 5, 'veg', 1.00),
(1897, 'SQP-0005', 'Patak\'s Wraps 6 pack', 'Patak\'s', 2, 'veg', 2.00),
(1898, 'SQP-0067', 'Walkers Apples Family Size', 'Walkers', 1, 'vegan', 3.00),
(1899, 'SQP-0119', 'Volvic Co-op Chickpeas 6 pack', 'Volvic', 9, 'vegan', 1.00),
(1900, 'SQP-0027', 'John West Tofu 500ml', 'John West', 6, 'vegan', 3.00),
(1901, 'SQP-0012', 'Tilda Butter 1L', 'Tilda', 5, 'veg', 2.00),
(1902, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 9, 'veg', 2.00),
(1903, 'SQP-0032', 'John West Chicken Breast Fillets 8 pack', 'John West', 2, 'halal', 5.00),
(1904, 'SQP-0139', 'Arla Beef Mince 2kg', 'Arla', 10, 'halal', 4.00),
(1905, 'SQP-0038', 'Lurpak Bread Loaf 1kg', 'Lurpak', 10, 'veg', 2.00),
(1906, 'SQP-0043', 'Twinings Bananas 750g', 'Twinings', 1, 'halal', 2.00),
(1907, 'SQP-0108', 'Linda McCartney Salmon Fillets 6 pack', 'Linda McCartney', 10, 'halal', 10.00),
(1908, 'SQP-0010', 'Warburtons Apples 500g', 'Warburtons', 7, 'halal', 2.00),
(1909, 'SQP-0093', 'Coca-Cola Free-range Eggs 500ml', 'Coca-Cola', 6, 'veg', 3.00),
(1910, 'SQP-0112', 'Dolmio Salmon Fillets 250g', 'Dolmio', 10, 'halal', 9.00),
(1911, 'SQP-0103', 'Dolmio Tofu 250g', 'Dolmio', 9, 'veg', 2.00),
(1912, 'SQP-0038', 'Twinings Bread Loaf 1kg', 'Twinings', 6, 'veg', 2.00),
(1913, 'SQP-0003', 'Nestlé Pasta 500g', 'Nestlé', 6, 'veg', 1.00),
(1914, 'SQP-0018', 'Cathedral City Tofu 1L', 'Cathedral City', 6, 'veg', 3.00),
(1915, 'SQP-0006', 'Nestlé Cheddar Cheese 1kg', 'Nestlé', 4, 'veg', 3.00),
(1916, 'SQP-0117', 'Heinz Tea Bags 500g', 'Heinz', 1, 'veg', 4.00),
(1917, 'SQP-0009', 'Tilda Frozen Peas 6 pack', 'Tilda', 10, 'vegan', 2.00),
(1918, 'SQP-0070', 'Yeo Valley Bananas 250g', 'Yeo Valley', 9, 'veg', 1.00),
(1919, 'SQP-0026', 'Lurpak Sparkling Water 2kg', 'Lurpak', 5, 'halal', 1.00),
(1920, 'SQP-0112', 'Dolmio Salmon Fillets 250g', 'Dolmio', 4, 'halal', 10.00),
(1921, 'SQP-0029', 'Coca-Cola Olive Oil 4 pack', 'Coca-Cola', 5, 'vegan', 5.00),
(1922, 'SQP-0031', 'Walkers Lentils 8 pack', 'Walkers', 1, 'halal', 2.00),
(1923, 'SQP-0069', 'Yeo Valley Bananas Family Size', 'Yeo Valley', 2, 'halal', 2.00),
(1924, 'SQP-0038', 'Hovis Bread Loaf 1kg', 'Hovis', 8, 'veg', 1.00),
(1925, 'SQP-0076', 'Heinz Apples 12 pack', 'Heinz', 7, 'vegan', 3.00),
(1926, 'SQP-0063', 'Cadbury Tofu 2L', 'Cadbury', 2, 'vegan', 3.00),
(1927, 'SQP-0117', 'Heinz Tea Bags 500g', 'Heinz', 10, 'veg', 4.00),
(1928, 'SQP-0099', 'Green Giant Tomato Sauce 750g', 'Green Giant', 4, 'vegan', 3.00),
(1929, 'SQP-0118', 'Hovis Free-range Eggs 4 pack', 'Hovis', 9, 'veg', 3.00),
(1930, 'SQP-0121', 'Volvic Chocolate Bar 4 pack', 'Volvic', 5, 'veg', 1.00),
(1931, 'SQP-0057', 'Hovis Wraps 12 pack', 'Hovis', 4, 'veg', 2.00),
(1932, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 7, 'veg', 2.00),
(1933, 'SQP-0042', 'Quorn Salmon Fillets 2L', 'Quorn', 4, 'halal', 6.00),
(1934, 'SQP-0126', 'Arla Chicken Breast Fillets 500g', 'Arla', 5, 'halal', 4.00),
(1935, 'SQP-0076', 'Heinz Apples 12 pack', 'Heinz', 1, 'vegan', 2.00),
(1936, 'SQP-0142', 'Yeo Valley Ice Cream Tub 1L', 'Yeo Valley', 2, 'veg', 6.00),
(1937, 'SQP-0113', 'Cathedral City Tomato Sauce 250g', 'Cathedral City', 1, 'veg', 2.00),
(1938, 'SQP-0091', 'Hovis Wraps 1kg', 'Hovis', 2, 'veg', 1.00),
(1939, 'SQP-0107', 'Patak\'s Pasta 330ml', 'Patak\'s', 6, 'vegan', 2.00),
(1940, 'SQP-0052', 'Twinings Veggie Burger 1L', 'Twinings', 10, 'veg', 4.00),
(1941, 'SQP-0133', 'Patak\'s Pasta 8 pack', 'Patak\'s', 2, 'veg', 3.00),
(1942, 'SQP-0069', 'Napolina Bananas Family Size', 'Napolina', 3, 'halal', 1.00),
(1943, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 7, 'veg', 3.00),
(1944, 'SQP-0031', 'Walkers Lentils 8 pack', 'Walkers', 8, 'halal', 2.00),
(1945, 'SQP-0039', 'Heinz Tofu 330ml', 'Heinz', 7, 'veg', 4.00),
(1946, 'SQP-0029', 'Coca-Cola Olive Oil 4 pack', 'Coca-Cola', 7, 'vegan', 9.00),
(1947, 'SQP-0074', 'Ben & Jerry\'s Chocolate Bar 500g', 'Ben & Jerry\'s', 6, 'veg', 2.00),
(1948, 'SQP-0135', 'Coca-Cola Veggie Burger 6 pack', 'Coca-Cola', 9, 'vegan', 4.00),
(1949, 'SQP-0002', 'Twinings Wraps 4 pack', 'Twinings', 8, 'veg', 2.00),
(1950, 'SQP-0048', 'Pepsi Chocolate Bar 12 pack', 'Pepsi', 9, 'veg', 1.00),
(1951, 'SQP-0112', 'Dolmio Salmon Fillets 250g', 'Dolmio', 10, 'halal', 6.00),
(1952, 'SQP-0023', 'Ben & Jerry\'s Pasta 2kg', 'Ben & Jerry\'s', 6, 'vegan', 2.00),
(1953, 'SQP-0063', 'Kellogg\'s Tofu 2L', 'Kellogg\'s', 6, 'vegan', 2.00),
(1954, 'SQP-0003', 'Nestlé Pasta 500g', 'Nestlé', 1, 'veg', 1.00),
(1955, 'SQP-0128', 'Heinz Chicken Breast Fillets 6 pack', 'Heinz', 5, 'halal', 9.00),
(1956, 'SQP-0138', 'Napolina Olive Oil 6 pack', 'Napolina', 10, 'vegan', 10.00),
(1957, 'SQP-0133', 'Patak\'s Pasta 8 pack', 'Patak\'s', 7, 'veg', 2.00),
(1958, 'SQP-0011', 'John West Olive Oil 2L', 'John West', 10, 'veg', 8.00),
(1959, 'SQP-0003', 'Nestlé Pasta 500g', 'Nestlé', 2, 'veg', 1.00),
(1960, 'SQP-0105', 'Cathedral City Tomato Passata 500g', 'Cathedral City', 6, 'veg', 2.00),
(1961, 'SQP-0147', 'Cathedral City Beef Mince 500ml', 'Cathedral City', 3, 'halal', 9.00),
(1962, 'SQP-0125', 'Pepsi Frozen Peas 8 pack', 'Pepsi', 7, 'halal', 2.00),
(1963, 'SQP-0088', 'Quorn Co-op Tofu 500g', 'Quorn', 9, 'veg', 2.00),
(1964, 'SQP-0044', 'Ben & Jerry\'s Semi-skimmed Milk 2L', 'Ben & Jerry\'s', 6, 'veg', 1.00),
(1965, 'SQP-0080', 'Nando\'s Cola Soft Drink Family Size', 'Nando\'s', 9, 'veg', 2.00),
(1966, 'SQP-0088', 'Nando\'s Co-op Tofu 500g', 'Nando\'s', 9, 'veg', 4.00),
(1967, 'SQP-0041', 'Cadbury Breakfast Cereal 8 pack', 'Cadbury', 9, 'vegan', 3.00),
(1968, 'SQP-0054', 'Cadbury Pasta 1kg', 'Cadbury', 9, 'veg', 3.00),
(1969, 'SQP-0047', 'Yeo Valley Tea Bags 330ml', 'Yeo Valley', 1, 'halal', 5.00),
(1970, 'SQP-0028', 'Walkers Basmati Rice 1kg', 'Walkers', 6, 'halal', 3.00),
(1971, 'SQP-0106', 'Coca-Cola Apples 500ml', 'Coca-Cola', 1, 'halal', 3.00),
(1972, 'SQP-0142', 'Yeo Valley Ice Cream Tub 1L', 'Yeo Valley', 1, 'veg', 7.00),
(1973, 'SQP-0026', 'Lurpak Sparkling Water 2kg', 'Lurpak', 10, 'halal', 1.00),
(1974, 'SQP-0051', 'Napolina Chocolate Bar 1L', 'Napolina', 3, 'veg', 2.00),
(1975, 'SQP-0146', 'Arla Olive Oil 250g', 'Arla', 5, 'vegan', 9.00),
(1976, 'SQP-0132', 'Evian Bread Loaf 2kg', 'Evian', 3, 'veg', 2.00),
(1977, 'SQP-0032', 'John West Chicken Breast Fillets 8 pack', 'John West', 3, 'halal', 5.00),
(1978, 'SQP-0028', 'Walkers Basmati Rice 1kg', 'Walkers', 1, 'halal', 1.00),
(1979, 'SQP-0134', 'Kellogg\'s Cheddar Cheese 1L', 'Kellogg\'s', 8, 'veg', 5.00),
(1980, 'SQP-0111', 'Evian Cheddar Cheese 2L', 'Evian', 1, 'veg', 4.00),
(1981, 'SQP-0083', 'Ben & Jerry\'s Cola Soft Drink 750g', 'Ben & Jerry\'s', 3, 'halal', 3.00),
(1982, 'SQP-0071', 'Heinz Veggie Burger 12 pack', 'Heinz', 3, 'vegan', 2.00),
(1983, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 2, 'veg', 2.00),
(1984, 'SQP-0099', 'Green Giant Tomato Sauce 750g', 'Green Giant', 1, 'vegan', 2.00),
(1985, 'SQP-0150', 'Oatly Wraps 8 pack', 'Oatly', 1, 'veg', 2.00),
(1986, 'SQP-0062', 'Green Giant Free-range Eggs Family Size', 'Green Giant', 4, 'veg', 2.00),
(1987, 'SQP-0045', 'Kellogg\'s Sparkling Water 8 pack', 'Kellogg\'s', 6, 'veg', 1.00),
(1988, 'SQP-0078', 'Yeo Valley Butter 2L', 'Yeo Valley', 7, 'veg', 3.00),
(1989, 'SQP-0018', 'Heinz Tofu 1L', 'Heinz', 4, 'veg', 3.00),
(1990, 'SQP-0057', 'Hovis Wraps 12 pack', 'Hovis', 7, 'veg', 2.00),
(1991, 'SQP-0006', 'Nestlé Cheddar Cheese 1kg', 'Nestlé', 4, 'veg', 2.00),
(1992, 'SQP-0092', 'Volvic Whole Milk 12 pack', 'Volvic', 7, 'veg', 2.00),
(1993, 'SQP-0102', 'Cathedral City Chickpeas 2L', 'Cathedral City', 9, 'halal', 1.00),
(1994, 'SQP-0137', 'Tilda Veggie Burger 750g', 'Tilda', 7, 'vegan', 2.00),
(1995, 'SQP-0032', 'John West Chicken Breast Fillets 8 pack', 'John West', 7, 'halal', 8.00),
(1996, 'SQP-0142', 'Yeo Valley Ice Cream Tub 1L', 'Yeo Valley', 4, 'veg', 5.00),
(1997, 'SQP-0073', 'John West Lentils 2L', 'John West', 6, 'halal', 1.00),
(1998, 'SQP-0072', 'Green Giant Olive Oil 8 pack', 'Green Giant', 1, 'vegan', 5.00),
(1999, 'SQP-0062', 'Green Giant Free-range Eggs Family Size', 'Green Giant', 3, 'veg', 2.00),
(2000, 'SQP-0140', 'Ben & Jerry\'s Butter 500g', 'Ben & Jerry\'s', 3, 'veg', 3.00),
(2417, NULL, '2002. Sport Cap Fa', NULL, 13, NULL, 3.99),
(2418, NULL, '12 Pk Diet Cola Fb', NULL, 13, NULL, 2.99),
(2419, NULL, 'Parmesan Cheese Fa', NULL, 13, NULL, 2.99),
(2420, NULL, 'Light Sour Crean Fa', NULL, 13, NULL, 0.99),
(2421, NULL, 'Yel Low Onions Fa', NULL, 13, NULL, 1.49),
(2422, NULL, 'Sweet Potatoes Fa', NULL, 13, NULL, 2.49),
(2423, NULL, 'Freshground Turkey Fa', NULL, 13, NULL, 2.99),
(2424, NULL, 'Chicken Tenderloin Fa', NULL, 13, NULL, 6.73),
(2425, NULL, 'Mixed Nuts Oz Fa', NULL, 13, NULL, 14.75),
(2426, NULL, 'Mixed Nuts Oz Fa', NULL, 13, NULL, 14.75),
(2427, NULL, 'Grape Tomatoes 1Pt Fa', NULL, 13, NULL, 1.89),
(2428, NULL, 'Red Grapes Fa', NULL, 13, NULL, 5.54),
(2429, NULL, 'Tb X /1B', NULL, 13, NULL, 2.42),
(2430, NULL, 'Stranberries Fa', NULL, 13, NULL, 1.49),
(2431, NULL, 'Baby Carrots Fa', NULL, 13, NULL, 1.25),
(2432, NULL, 'Asian Salad Kit Fa', NULL, 13, NULL, 2.49),
(2433, NULL, 'Sprd Cheese Wedges Fa', NULL, 13, NULL, 1.29),
(2434, NULL, 'Garden Salad Fa', NULL, 13, NULL, 0.89),
(2435, NULL, 'Garden Salad Fa', NULL, 13, NULL, 0.89),
(2436, NULL, 'Baby Carrots Fa', NULL, 13, NULL, 1.25),
(2437, NULL, 'Garlic Fa', NULL, 13, NULL, 0.85),
(2438, NULL, '‘Sweetandsal Tybars Fa', NULL, 13, NULL, 1.39),
(2439, NULL, 'Turkey Meatballs Fa', NULL, 13, NULL, 4.39),
(2440, NULL, 'Swt Chili/Sriracha Fa', NULL, 13, NULL, 4.99),
(2441, NULL, 'Zucchini Fa', NULL, 13, NULL, 1.69),
(2442, NULL, 'Seediss Watermelon Fa', NULL, 13, NULL, 2.99),
(2443, NULL, '2002. Sport Cap Fa', NULL, 14, NULL, 3.99),
(2444, NULL, '12 Pk Diet Cola Fb', NULL, 14, NULL, 2.99),
(2445, NULL, 'Parmesan Cheese Fa', NULL, 14, NULL, 2.99),
(2446, NULL, 'Light Sour Crean Fa', NULL, 14, NULL, 0.99),
(2447, NULL, 'Yel Low Onions Fa', NULL, 14, NULL, 1.49),
(2448, NULL, 'Sweet Potatoes Fa', NULL, 14, NULL, 2.49),
(2449, NULL, 'Freshground Turkey Fa', NULL, 14, NULL, 2.99),
(2450, NULL, 'Chicken Tenderloin Fa', NULL, 14, NULL, 6.73),
(2451, NULL, 'Mixed Nuts Oz Fa', NULL, 14, NULL, 14.75),
(2452, NULL, 'Mixed Nuts Oz Fa', NULL, 14, NULL, 14.75),
(2453, NULL, 'Grape Tomatoes 1Pt Fa', NULL, 14, NULL, 1.89),
(2454, NULL, 'Red Grapes Fa', NULL, 14, NULL, 5.54),
(2455, NULL, 'Tb X /1B', NULL, 14, NULL, 2.42),
(2456, NULL, 'Stranberries Fa', NULL, 14, NULL, 1.49),
(2457, NULL, 'Baby Carrots Fa', NULL, 14, NULL, 1.25),
(2458, NULL, 'Asian Salad Kit Fa', NULL, 14, NULL, 2.49),
(2459, NULL, 'Sprd Cheese Wedges Fa', NULL, 14, NULL, 1.29),
(2460, NULL, 'Garden Salad Fa', NULL, 14, NULL, 0.89),
(2461, NULL, 'Garden Salad Fa', NULL, 14, NULL, 0.89),
(2462, NULL, 'Baby Carrots Fa', NULL, 14, NULL, 1.25),
(2463, NULL, 'Garlic Fa', NULL, 14, NULL, 0.85),
(2464, NULL, '‘Sweetandsal Tybars Fa', NULL, 14, NULL, 1.39),
(2465, NULL, 'Turkey Meatballs Fa', NULL, 14, NULL, 4.39),
(2466, NULL, 'Swt Chili/Sriracha Fa', NULL, 14, NULL, 4.99),
(2467, NULL, 'Zucchini Fa', NULL, 14, NULL, 1.69),
(2468, NULL, 'Seediss Watermelon Fa', NULL, 14, NULL, 2.99);

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` int(11) NOT NULL,
  `store_name` varchar(50) NOT NULL,
  `postcode` varchar(19) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `store_name`, `postcode`, `location`) VALUES
(1, 'Tesco', 'M1 1AE', NULL),
(2, 'Asda', 'M1 5DB', NULL),
(3, 'Aldi', 'M2 4EN', NULL),
(4, 'Lidl', 'M2 1DY', NULL),
(5, 'Sainsbury\'s', 'M3 3EQ', NULL),
(6, 'Morrisons', 'M3 5JD', NULL),
(7, 'Waitrose', 'M4 2AF', NULL),
(8, 'Iceland', 'M4 0AQ', NULL),
(9, 'Co-Op', 'M5 4DH', NULL),
(10, 'Marks & Spencer', 'M5 1AB', NULL),
(13, 'ADI', NULL, '930 DEKALB PIKE'),
(14, 'ALDI', NULL, '930 DEKALB PIKE');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `password`) VALUES
(1, 'Kainat@shopquick.com', 'kainat1'),
(2, 'aliya@shopquick.com', 'aliya2'),
(3, 'mahnoor@shopquick.com', 'mahnoor3'),
(4, 'lazhary@shopquick.com', 'lazhary4'),
(5, 'armaan@shopquick.com', 'armaan5');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2469;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
