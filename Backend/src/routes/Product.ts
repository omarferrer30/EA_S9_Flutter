import express from 'express';
import controller from '../controllers/Product';
import { Schemas, ValidateSchema } from '../middleware/ValidateSchema';

const router = express.Router();

router.post('/createproduct', ValidateSchema(Schemas.product.create), controller.createProduct);
router.get('/readproduct/:productId', controller.readProduct);
router.get('/readall', controller.readAll);
router.put('/updateproduct/:productId', ValidateSchema(Schemas.product.update), controller.updateProduct);
router.delete('/deleteproduct/:productId', controller.deleteProduct);

export = router;
