module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet = var.public_subnet
  private_subnet = var.private_subnet
  region = var.region
}


module "endpoints" {
  source = "./modules/endpoints"
  
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  private_route_table_ids = module.vpc.private_route_table_ids
  vpc_cidr_block          = var.vpc_cidr_block
}