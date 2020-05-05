ALTER TABLE isbasedon ALTER COLUMN author DROP not null;
ALTER TABLE Material ALTER COLUMN MaterialLanguageKey TYPE TEXT;

ALTER TABLE IF EXISTS isbasedon DROP CONSTRAINT constraint_isbasedon;
ALTER TABLE isbasedon ADD CONSTRAINT constraint_isbasedon UNIQUE (materialname,educationalmaterialid);

CREATE TABLE IsBasedOnAuthor (
  Id           BIGSERIAL NOT NULL, 
  AuthorName  text NOT NULL, 
  IsBasedOnId int8 NOT NULL, 
  PRIMARY KEY (Id));
ALTER TABLE IsBasedOnAuthor ADD CONSTRAINT FKIsBasedOnAuthor FOREIGN KEY (IsBasedOnId) REFERENCES IsBasedOn (Id);

ALTER TABLE isbasedon DROP COLUMN author;

ALTER TABLE attachment ADD COLUMN Obsoleted int4 DEFAULT 0 NOT NULL;

--24.3.2020 feat-582
ALTER TABLE educationalmaterial ADD COLUMN SuitsAllUpperSecondarySubjectsNew bool DEFAULT 'false' NOT NULL;

--feat 592
CREATE TABLE Rating (
  Id                     BIGSERIAL NOT NULL, 
  RatingContent         int4, 
  RatingVisual          int4, 
  FeedbackPositive      varchar(1000), 
  FeedbackSuggest       varchar(1000), 
  FeedbackPurpose       varchar(1000), 
  EducationalMaterialId int8 NOT NULL, 
  UsersUserName         text NOT NULL,
  UpdatedAt        timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (Id));
ALTER TABLE Rating ADD CONSTRAINT FKRatingUsers FOREIGN KEY (UsersUserName) REFERENCES Users (UserName);
ALTER TABLE Rating ADD CONSTRAINT FKRatingEducationalMaterial FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);
ALTER TABLE Rating ADD CONSTRAINT constraint_Rating UNIQUE (UsersUserName,educationalmaterialid);
ALTER TABLE educationalmaterial ADD COLUMN RatingContentAverage NUMERIC (2, 1);
ALTER TABLE educationalmaterial ADD COLUMN RatingVisualAverage NUMERIC (2, 1);

--feat 628
ALTER TABLE educationalmaterial ALTER COLUMN agerangemin DROP DEFAULT;
ALTER TABLE educationalmaterial ALTER COLUMN agerangemin DROP NOT NULL;
ALTER TABLE educationalmaterial ALTER COLUMN agerangemax DROP DEFAULT;
ALTER TABLE educationalmaterial ALTER COLUMN agerangemax DROP NOT NULL;
ALTER TABLE educationalmaterial ALTER COLUMN expires DROP NOT NULL;
ALTER TABLE alignmentobject DROP CONSTRAINT constraint_alignmentobject;
ALTER TABLE alignmentobject ADD CONSTRAINT constraint_alignmentobject UNIQUE (alignmentType, objectkey, source, educationalmaterialid);

-- 2.0.0

CREATE TABLE VersionComposition (
  EducationalMaterialId int8 NOT NULL, 
  MaterialId            int8 NOT NULL, 
  PublishedAt           timestamp NOT NULL, 
  Priority              int4, 
  PRIMARY KEY (EducationalMaterialId, 
  MaterialId, 
  PublishedAt));
ALTER TABLE VersionComposition ADD CONSTRAINT FKMaterialVersion FOREIGN KEY (MaterialId) REFERENCES Material (Id);
ALTER TABLE VersionComposition ADD CONSTRAINT FKEducationalMaterialVersion FOREIGN KEY (EducationalMaterialId) REFERENCES EducationalMaterial (Id);

INSERT INTO VersionComposition (EducationalMaterialId, PublishedAt, MaterialId, priority)
SELECT em.Id as EducationalMaterialId, em.PublishedAt::timestamp(3), m.Id as MaterialId, m.Priority
FROM EducationalMaterial AS em
JOIN Material AS m
ON em.Id = m.EducationalMaterialId
WHERE em.PublishedAt IS NOT NULL;
--ON CONFLICT (EducationalMaterialId, PublishedAt, MaterialId) DO NOTHING;

CREATE TABLE AttachmentVersionComposition (
  VersionEducationalMaterialId int8 NOT NULL, 
  VersionMaterialId            int8 NOT NULL, 
  VersionPublishedAt           timestamp NOT NULL, 
  AttachmentId                            int8 NOT NULL, 
  PRIMARY KEY (VersionEducationalMaterialId, 
  VersionMaterialId, 
  VersionPublishedAt, 
  AttachmentId));
ALTER TABLE AttachmentVersionComposition ADD CONSTRAINT FKVersionCompositionAttachment FOREIGN KEY (VersionEducationalMaterialId, VersionMaterialId, VersionPublishedAt) REFERENCES VersionComposition (EducationalMaterialId, MaterialId, PublishedAt);
ALTER TABLE AttachmentVersionComposition ADD CONSTRAINT FKAttachmentVersion FOREIGN KEY (AttachmentId) REFERENCES Attachment (Id);


INSERT INTO AttachmentVersionComposition (VersionEducationalMaterialId, VersionPublishedAt, VersionMaterialId, AttachmentId)
SELECT em.Id as EducationalMaterialId, em.PublishedAt::timestamp(3), m.Id as MaterialId, attachment.id
FROM EducationalMaterial AS em
JOIN Material AS m
ON em.Id = m.EducationalMaterialId
JOIN attachment
ON m.id = attachment.MaterialId
WHERE em.PublishedAt IS NOT NULL;

-- readable codes

CREATE TABLE LicenseCode (
  Code text NOT NULL, 
  License text NOT NULL, 
  PRIMARY KEY (Code));

INSERT INTO LicenseCode (Code, License) VALUES ('CCBY4.0', 'CC BY 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYNC4.0', 'CC BY-NC 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYNCND4.0', 'CC BY-NC-ND 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYNCSA4.0', 'CC BY-NC-SA 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYND4.0', 'CC BY-ND 4.0');
INSERT INTO LicenseCode (Code, License) VALUES ('CCBYSA4.0', 'CC BY-SA 4.0');