USE [Parshva]
GO

DECLARE	@return_value int
EXEC	@return_value = [dbo].[ExpireHoarding]
SELECT	'ExpireHoarding' = @return_value
GO

DECLARE	@return_value int
EXEC	@return_value = [dbo].ExpireTemporaryHoarding
SELECT	'ExpireTemporaryHoarding' = @return_value
GO
