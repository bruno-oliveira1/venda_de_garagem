-- Criando o banco
-- psql -U postgres -c "CREATE DATABASE garagem WITH ENCODING 'UTF8' LC_COLLATE='pt_BR.UTF-8' LC_CTYPE='pt_BR.UTF-8' TEMPLATE=template0;"

CREATE TYPE genero_enum AS ENUM ('Masculino', 'Feminino', 'Outros');

CREATE TABLE "usuario" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "nome" varchar NOT NULL,
  "data_nascimento" date NOT NULL,
  "cpf" varchar NOT NULL,
  "genero" genero_enum NOT NULL,
  "cep" varchar NOT NULL,
  "endereco" varchar NOT NULL,
  "complemento" varchar NOT NULL,
  "email" varchar NOT NULL,
  "telefone" varchar NOT NULL
);

CREATE TABLE "espaco" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "usuario_id" int NOT NULL,
  "nome" varchar NOT NULL,
  "descricao" text NOT NULL,
  "valor_diaria" numeric NOT NULL,
  "exclusivo" boolean NOT NULL,
  "cep" varchar NOT NULL,
  "endereco" varchar NOT NULL,
  "complemento" varchar NOT NULL
);

CREATE TABLE "disponibilidade" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "espaco_id" int NOT NULL,
  "data" date NOT NULL
);

CREATE TABLE "reserva" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "usuario_id" int NOT NULL,
  "disponibilidade_id" int NOT NULL,
  "valor_pago" numeric NOT NULL,
  "taxa_site" numeric NOT NULL,
  "data_pagamento" timestamp,
  "data_cancelamento" timestamp NOT NULL
);

CREATE TABLE "pagamento" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "reserva_id" int NOT NULL,
  "metodo" varchar NOT NULL,
  "status" varchar NOT NULL,
  "valor_total" numeric NOT NULL,
  "data_confirmacao" timestamp
);

CREATE TABLE "foto_espaco" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "espaco_id" int NOT NULL,
  "url_imagem" text NOT NULL,
  "descricao" text
);

CREATE TABLE "cancelamento" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "reserva_id" int NOT NULL,
  "motivo" text,
  "data_cancelamento" timestamp NOT NULL,
  "tipo" varchar
);

CREATE TABLE "feedback" (
"id" INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "usuario_id" int NOT NULL,
  "espaco_id" int NOT NULL,
  "nota" int NOT NULL,
  "comentario" text,
  "data" timestamp NOT NULL
);

CREATE UNIQUE INDEX ON "usuario" ("cpf");
CREATE UNIQUE INDEX ON "usuario" ("email");

ALTER TABLE "espaco" ADD FOREIGN KEY ("usuario_id") REFERENCES "usuario" ("id"); 
ALTER TABLE "disponibilidade" ADD FOREIGN KEY ("espaco_id") REFERENCES "espaco" ("id"); 
ALTER TABLE "reserva" ADD FOREIGN KEY ("usuario_id") REFERENCES "usuario" ("id"); 
ALTER TABLE "reserva" ADD FOREIGN KEY ("disponibilidade_id") REFERENCES "disponibilidade" ("id"); 
ALTER TABLE "pagamento" ADD FOREIGN KEY ("reserva_id") REFERENCES "reserva" ("id"); 
ALTER TABLE "foto_espaco" ADD FOREIGN KEY ("espaco_id") REFERENCES "espaco" ("id"); 
ALTER TABLE "cancelamento" ADD FOREIGN KEY ("reserva_id") REFERENCES "reserva" ("id"); 
ALTER TABLE "feedback" ADD FOREIGN KEY ("usuario_id") REFERENCES "usuario" ("id"); 
ALTER TABLE "feedback" ADD FOREIGN KEY ("espaco_id") REFERENCES "espaco" ("id"); 