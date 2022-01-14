-- DROP DATABASE ProyectManagement

CREATE DATABASE ProyectManagement;

USE ProyectManagement;

CREATE TABLE Sex(
  idSex TINYINT IDENTITY(1, 1) PRIMARY KEY,
  descriptionS VARCHAR(15) NOT NULL,
);

CREATE TABLE Trimester(
  idTrimester TINYINT IDENTITY(1, 1) PRIMARY KEY,
  descriptionT VARCHAR(50) NOT NULL,
);

CREATE TABLE Departament(
  idDepartment TINYINT IDENTITY(1, 1) PRIMARY KEY,
  descriptionD VARCHAR(30) NOT NULL,
  stateD BIT DEFAULT 1 NOT NULL
);

CREATE TABLE FunctionaryType(
  idFunctionaryType TINYINT IDENTITY(1, 1) PRIMARY KEY,
  descriptionFT VARCHAR(15) NOT NULL
);

CREATE TABLE Functionary(
  idFunctionary SMALLINT IDENTITY(1, 1) PRIMARY KEY,
  idSex TINYINT NOT NULL,
  idDepartment TINYINT NOT NULL,
  idFunctionaryType TINYINT NOT NULL,

  nameF VARCHAR(15) NOT NULL,
  surName VARCHAR(15) NOT NULL,
  lastName VARCHAR(15) NOT NULL,
  birthday DATE NOT NULL,
  email VARCHAR(50) UNIQUE NOT NULL,
  pass VARBINARY(MAX) NOT NULL,
  urlPhoto VARCHAR(180) NOT NULL,
  stateF BIT DEFAULT 1 NOT NULL,
  secretUrl VARCHAR(60) NOT NULL

  CONSTRAINT FuncionarySex -- Funcionary_Sex
  FOREIGN KEY (idSex) 
  REFERENCES Sex(idSex),

  CONSTRAINT FuncionaryDepartament  -- Funcionary_Departament
  FOREIGN KEY (idDepartment) 
  REFERENCES Departament(idDepartment),

  CONSTRAINT FuncionaryFuncionaryType 
  FOREIGN KEY (idFunctionaryType) 
  REFERENCES FunctionaryType(idFunctionaryType)
);

CREATE TABLE Solicitation(
  idSolicitation SMALLINT IDENTITY(1, 1) PRIMARY KEY,
  idFunctionaryA SMALLINT NOT NULL,
  idFunctionaryR SMALLINT NOT NULL,
  idFunctionaryF SMALLINT NOT NULL,
  solicitationDate SMALLDATETIME NOT NULL,
  startDate DATE NOT NULL,
  endingDate DATE NOT NULL,
  document VARBINARY(MAX) NOT NULL,
  stateS BIT default 1 NOT NULL,
  finished BIT default 0 NOT NULL,
  
  CONSTRAINT FuncionaryASolicitation
  FOREIGN KEY (idFunctionaryA) 
  REFERENCES Functionary(idFunctionary),
  
  CONSTRAINT FuncionaryRSolicitation 
  FOREIGN KEY (idFunctionaryR) 
  REFERENCES Functionary(idFunctionary),
  
  CONSTRAINT FuncionaryFSolicitation 
  FOREIGN KEY (idFunctionaryF) 
  REFERENCES Functionary(idFunctionary)
);

CREATE TABLE Advance(
  idAdvance INTEGER IDENTITY(1, 1) PRIMARY KEY,
  idTrimester TINYINT NOT NULL,
  idFunctionaryA SMALLINT NOT NULL,
  idSolicitation SMALLINT NOT NULL,
  advanceDate SMALLDATETIME NOT NULL,
  document VARBINARY(MAX) NOT NULL,
  stateA BIT default 1 NOT NULL,

  CONSTRAINT AdvanceTrimester 
  FOREIGN KEY (idTrimester) 
  REFERENCES Trimester(idTrimester),
  
  CONSTRAINT AdvanceSolicitation 
  FOREIGN KEY (idSolicitation) 
  REFERENCES Solicitation(idSolicitation),
  
  CONSTRAINT FunctionaryAAdvance
  FOREIGN KEY (idFunctionaryA) 
  REFERENCES Functionary(idFunctionary)
);

CREATE TABLE TransactionAll(
  idTransaction TINYINT IDENTITY(1, 1) PRIMARY KEY,
  descriptionT VARCHAR(50) NOT NULL
);

CREATE TABLE Binnacle(
  idBinnacle INTEGER IDENTITY(1, 1) PRIMARY KEY,
  idTransaction TINYINT NOT NULL,
  idFunctionaryA SMALLINT NOT NULL,
  idAdvance INTEGER NOT NULL,
  idSolicitation SMALLINT NOT NULL,
  binnacleDate SMALLDATETIME NOT NULL

  CONSTRAINT BinnacleTransaction 
  FOREIGN KEY (idTransaction) 
  REFERENCES TransactionAll(idTransaction),
  
  CONSTRAINT BinnacleFunctionaryA
  FOREIGN KEY (idFunctionaryA) 
  REFERENCES Functionary(idFunctionary),
  
  CONSTRAINT BinnacleAdvance
  FOREIGN KEY (idAdvance) 
  REFERENCES Advance(idAdvance),

  CONSTRAINT BinnacleSolicitation
  FOREIGN KEY (idSolicitation) 
  REFERENCES Solicitation(idSolicitation)
);

CREATE TABLE SignIn(
  idFunctionary SMALLINT PRIMARY KEY,
  ipFunctionary VARCHAR(16) NOT NULL

  CONSTRAINT SignInFunctionary
  FOREIGN KEY (idFunctionary) 
  REFERENCES Functionary(idFunctionary)
);

CREATE TABLE NotificationLogin(
  idNotification SMALLINT IDENTITY(1, 1) PRIMARY KEY,
  idFunctionary SMALLINT NOT NULL,
  descriptionN VARCHAR(100) NOT NULL,
  ipFunctionary VARCHAR(16) NOT NULL

  CONSTRAINT NotificationSignIn
  FOREIGN KEY (idFunctionary) 
  REFERENCES SignIn(idFunctionary)
);