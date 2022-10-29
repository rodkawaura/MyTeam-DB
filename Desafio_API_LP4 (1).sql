SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Banco de dados: `lpiv_desafio_n1b2`
--



--
-- Estrutura da tabela `tb_employees`
--

CREATE TABLE `tb_employees` (
  `name` varchar(100) NOT NULL,
  `rg` varchar(15) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `genre` char(1) NOT NULL,
  `dt_birthday` date NOT NULL,
  `dt_admission` date NOT NULL,
  `dt_resignation` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_feedbacks`
--

CREATE TABLE `tb_feedbacks` (
  `employee_cpf` varchar(14) NOT NULL,
  `feedbackid` int(50) NOT NULL,
  `feedback` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tb_positions`
--

CREATE TABLE `tb_positions` (
  `employee_cpf` varchar(14) NOT NULL,
  `positionid` int(11) NOT NULL,
  `positionname` varchar(50) NOT NULL,
  `positiondescription` varchar(250) NOT NULL,
  `dt_start` date NOT NULL,
  `dt_end` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `tb_employees`
--
ALTER TABLE `tb_employees`
  ADD PRIMARY KEY (`cpf`),
  ADD UNIQUE KEY `rg` (`rg`,`cpf`);

--
-- Índices para tabela `tb_feedbacks`
--
ALTER TABLE `tb_feedbacks`
  ADD PRIMARY KEY (`feedbackid`),
  ADD KEY `FK_tb_feedbacks_1` (`employee_cpf`);

--
-- Índices para tabela `tb_positions`
--
ALTER TABLE `tb_positions`
  ADD PRIMARY KEY (`positionid`),
  ADD KEY `FK_tb_positions_1` (`employee_cpf`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_feedbacks`
--
ALTER TABLE `tb_feedbacks`
  MODIFY `feedbackid` int(50) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tb_positions`
--
ALTER TABLE `tb_positions`
  MODIFY `positionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `tb_feedbacks`
--
ALTER TABLE `tb_feedbacks`
  ADD CONSTRAINT `FK_tb_feedbacks_1` FOREIGN KEY (`employee_cpf`) REFERENCES `tb_employees` (`cpf`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `tb_positions`
--
ALTER TABLE `tb_positions`
  ADD CONSTRAINT `FK_tb_positions_1` FOREIGN KEY (`employee_cpf`) REFERENCES `tb_employees` (`cpf`) ON DELETE CASCADE;
COMMIT;

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_employee` (IN `var_name` VARCHAR(100), IN `var_rg` VARCHAR(15), IN `var_cpf` VARCHAR(14), IN `var_genre` CHAR(1), IN `var_birthday` DATE, IN `var_admission` DATE, IN `var_resignation` DATE)   INSERT INTO tb_employees (name, rg, cpf, genre, dt_birthday, dt_admission) VALUES (var_name, var_rg, var_cpf, var_genre, var_birthday, var_admission)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_feedback` (IN `var_cpf` VARCHAR(14), IN `var_feedback` VARCHAR(500))   INSERT INTO tb_feedbacks (employee_cpf, feedback) VALUES (var_cpf, var_feedback)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_create_position` (IN `var_cpf` VARCHAR(14), IN `var_position` VARCHAR(50), IN `var_start` DATE, IN `var_end` DATE, IN `var_description` VARCHAR(250))   INSERT INTO tb_positions (employee_cpf, positionname, positiondescription, dt_start, dt_end) VALUES (var_cpf,  var_position, var_description, var_start, var_end)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_employee` (IN `var_cpf` VARCHAR(14))   DELETE FROM tb_employees WHERE cpf = var_cpf$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_feedback` (IN `var_feedbackid` VARCHAR(50))   DELETE FROM tb_feedbacks WHERE feedbackid = var_feedbackid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_position` (IN `var_positionid` VARCHAR(50))   DELETE FROM tb_positions WHERE positionid = var_positionid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_employee` (IN `var_name` VARCHAR(100), IN `var_cpf` VARCHAR(14), IN `var_genre` VARCHAR(1), IN `var_resignation` DATE)   UPDATE tb_employees SET 
name = var_name, genre = var_genre,  
dt_resignation = var_resignation WHERE cpf = var_cpf$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_feedback` (IN `var_feedbackid` VARCHAR(50), IN `var_feedback` VARCHAR(500))   UPDATE tb_feedbacks SET feedback = var_feedback WHERE feedbackid = var_feedbackid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_edit_position` (IN `var_positionid` VARCHAR(50), IN `var_position` VARCHAR(50), IN `var_start` DATE, IN `var_end` DATE, IN `var_description` VARCHAR(250))   UPDATE tb_positions 
SET positionname = var_position, dt_start = var_start, dt_end = var_end, positiondescription = var_description
WHERE positionid = var_positionid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_employee` ()   SELECT * FROM tb_employees$$

DELIMITER ;

-- --------------------------------------------------------
